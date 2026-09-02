#!/usr/bin/env bash
set -euo pipefail

# ============================================================================
# fix-nvidia-kernel.sh
# Repara el arranque tras un kernel panic causado por el driver NVIDIA.
#
# SÍNTOMA: tras actualizar el kernel (p.ej. a 7.0.x), el sistema hace
# kernel panic al arrancar. Causa: el driver NVIDIA anterior no compila
# contra la nueva API del kernel (VMA/MM), el post-install de linux-image
# queda "half-configured" (iF), no se genera el initramfs, y el boot falla.
#
# Este script DETECTA AUTOMÁTICAMENTE el kernel problemático y el estado
# del driver, y repara todo de forma segura e idempotente:
#   1. Detecta el kernel más reciente que está roto (sin initramfs, sin
#      módulo nvidia, o paquete linux-image en iF).
#   2. Instala dwarves (pahole) para el BTF.
#   3. Retira módulos DKMS nvidia rotos del kernel objetivo.
#   4. Actualiza el driver NVIDIA a la versión del repositorio (que sí
#      soporta el kernel nuevo).
#   5. Resuelve el conflicto EGL/sobrescritura de archivos que suele
#      bloquear el upgrade (bug de empaquetado de Ubuntu/NVIDIA).
#   6. Reconstruye los módulos DKMS y el initramfs del kernel objetivo.
#   7. Regenera GRUB.
#
# NO es destructivo: no purga el driver a menos que haga falta; usa
# forzar-sobrescritura y corrige dependencias. Se puede re-ejecutar.
#
# USO (como root):
#   sudo ./fix-nvidia-kernel.sh                 # repara el kernel más nuevo roto
#   sudo ./fix-nvidia-kernel.sh 7.0.0-30-generic # repara un kernel específico
# ============================================================================

log()  { printf "\033[1;34m== %s ==\033[0m\n" "$*"; }
ok()   { printf "\033[0;32m  ✓ %s\033[0m\n" "$*"; }
warn() { printf "\033[0;33m  ! %s\033[0m\n" "$*"; }

# ---------------------------------------------------------------------------
if [[ $EUID -ne 0 ]]; then
  echo "Este script debe ejecutarse como root (sudo)." >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# Detección del kernel objetivo
# ---------------------------------------------------------------------------
detect_target_kernel() {
  # Si el usuario pasó un kernel explícito, úsalo.
  if [[ -n "${1:-}" ]]; then
    TARGET="$1"
    if [[ ! -d "/lib/modules/$TARGET" ]]; then
      warn "El kernel '$TARGET' no existe en /lib/modules. Verifica."
      return 1
    fi
    return 0
  fi

  # Detecta el kernel más nuevo real (paquete linux-image en estado 'ii')
  # que esté "roto": paquete half-configured (iF), o sin initramfs, o sin
  # módulo nvidia DKMS. Los kernels en estado 'rc' (removidos, solo config)
  # se ignoran: ya no están instalados ni se arrancan.
  local newest_roken=""
  for ver in $(ls -1 /lib/modules/ 2>/dev/null | sort -V); do
    [[ -d "/lib/modules/$ver" ]] || continue

    # Solo considerar kernels con el paquete realmente instalado (ii).
    local pkg_state
    pkg_state="$(dpkg-query -W -f='${db:Status-Abbrev}' "linux-image-$ver" 2>/dev/null || true)"
    if [[ "$pkg_state" != "ii" ]]; then
      continue
    fi

    local has_initramfs="no" has_nv="no" pkg_hc="no"

    [[ -f "/boot/initrd.img-$ver" ]] && has_initramfs="yes"
    if dkms status 2>/dev/null | grep -q "nvidia.*, $ver.*installed"; then
      has_nv="yes"
    fi
    if dpkg -l 2>/dev/null | grep -qE "^iF\s+linux-image.*$ver"; then
      pkg_hc="yes"
    fi

    # Consideramos "roto" si le falta initramfs o módulo nvidia, o si el
    # paquete está half-configured.
    if [[ "$has_initramfs" == "no" || "$has_nv" == "no" || "$pkg_hc" == "yes" ]]; then
      newest_roken="$ver"
    fi
  done

  if [[ -z "$newest_roken" ]]; then
    # Fallback: el kernel más nuevo realmente instalado (ii).
    for ver in $(ls -1 /lib/modules/ 2>/dev/null | sort -V | tac); do
      local st
      st="$(dpkg-query -W -f='${db:Status-Abbrev}' "linux-image-$ver" 2>/dev/null || true)"
      if [[ "$st" == "ii" ]]; then
        newest_roken="$ver"
        break
      fi
    done
    [[ -z "$newest_roken" ]] && newest_roken="$(ls -1 /lib/modules/ 2>/dev/null | sort -V | tail -1)"
    warn "No se detectó un kernel roto; usando el más nuevo: $newest_roken"
  fi

  TARGET="$newest_roken"
  return 0
}

CUR_KERNEL="$(uname -r)"

if ! detect_target_kernel "${1:-}"; then
  exit 1
fi

log "Reparación del kernel: $TARGET"
ok "Kernel en ejecución: $CUR_KERNEL"

# ---------------------------------------------------------------------------
# Paso 1: Instalar dwarves (pahole) para el BTF
# ---------------------------------------------------------------------------
log "Paso 1: Instalar dwarves (pahole, necesario para BTF)"
if command -v pahole >/dev/null 2>&1; then
  ok "pahole ya instalado"
else
  DEBIAN_FRONTEND=noninteractive apt-get install -y dwarves \
    || warn "No se pudo instalar dwarves; el build puede fallar si el kernel requiere BTF"
fi

# ---------------------------------------------------------------------------
# Paso 2: Retirar módulos DKMS nvidia rotos del kernel objetivo
# ---------------------------------------------------------------------------
log "Paso 2: Retirar módulos DKMS nvidia rotos de $TARGET"
DKMS_REMOVED="no"
for ver in $(ls /var/lib/dkms/nvidia/ 2>/dev/null || true); do
  if dkms status "nvidia/$ver" 2>/dev/null | grep -q "$TARGET"; then
    if ! dkms status "nvidia/$ver" 2>/dev/null | grep -q "$TARGET.*installed"; then
      warn "Retirando nvidia/$ver (roto) de $TARGET..."
      dkms remove "nvidia/$ver" -k "$TARGET" || true
      DKMS_REMOVED="yes"
    fi
  fi
done
[[ "$DKMS_REMOVED" == "no" ]] && ok "Sin módulos nvidia rotos en $TARGET"

# ---------------------------------------------------------------------------
# Paso 3: Sincronizar los repos (por si el otro equipo no ha hecho apt update)
# ---------------------------------------------------------------------------
log "Paso 3: Actualizar la lista de paquetes"
apt-get update -o Acquire::Retries=3 2>&1 | tail -1 || warn "apt update no pudo completarse"

# ---------------------------------------------------------------------------
# Paso 4: Actualizar el driver NVIDIA a la versión del repositorio
# (La versión del repositorio soporta el kernel nuevo; la instalada no.)
# ---------------------------------------------------------------------------
log "Paso 4: Actualizar el driver NVIDIA a la última versión del repositorio"
# Detecta qué meta-paquete de driver usa el sistema (580, 570, 470...).
NV_META="$(dpkg-query -W -f='${Package}\n' 'nvidia-driver-*' 2>/dev/null \
  | grep -E '^nvidia-driver-[0-9]+$' | sort -V | tail -1 || true)"
if [[ -z "$NV_META" ]]; then
  # No hay driver instalado; instala la versión recomendada por ubuntu-drivers.
  NV_META="$(ubuntu-drivers devices 2>/dev/null | grep -oE 'nvidia-driver-[0-9]+' | head -1 || true)"
fi

if [[ -n "$NV_META" ]]; then
  ok "Driver detectado: $NV_META"
  # 1) Primero el upgrade del metapaquete (puede quedar iU si hay conflicto EGL).
  DEBIAN_FRONTEND=noninteractive apt-get install -y --only-upgrade "$NV_META" \
    || warn "upgrade de $NV_META terminó con avisos (se resolverá en el paso 6)"
else
  warn "No se detectó un driver NVIDIA instalado. Instalando el recomendado..."
  NV_META="$(ubuntu-drivers devices 2>/dev/null | grep -oE 'nvidia-driver-[0-9]+' | head -1)"
  [[ -z "$NV_META" ]] && NV_META="nvidia-driver-580"
  DEBIAN_FRONTEND=noninteractive apt-get install -y "$NV_META" \
    || warn "instalación de $NV_META terminó con avisos"
fi

# ---------------------------------------------------------------------------
# Paso 5: Alinear TODAS las librerías nvidia a la versión del driver instalado
# (El bug de empaquetado hace que a veces queden librerías de versiones
#  mezcladas, con un conflicto de sobrescritura en libnvidia-gl-580 vs
#  libnvidia-egl-*.)
# ---------------------------------------------------------------------------
log "Paso 5: Alinear las librerías nvidia (--force-overwrite + fix-broken)"
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-overwrite" \
  --fix-broken install || warn "fix-broken terminó con avisos"
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-overwrite" \
  full-upgrade || warn "full-upgrade terminó con avisos"
dpkg --configure -a || warn "dpkg --configure -a reportó errores"

# ---------------------------------------------------------------------------
# Paso 6: Verificar que el metapaquete quedó correctamente instalado (ii)
# Si sigue bloqueado por dependencias rotas, aplica el enfoque más agresivo:
# remover paquetes EGL huérfanos que bloquean el desempacado.
# ---------------------------------------------------------------------------
log "Paso 6: Resolver dependencias pendientes"
if ! dpkg -l "$NV_META" 2>/dev/null | grep -qE '^ii'; then
  warn "$NV_META sigue sin configurarse. Removiendo paquetes EGL huérfanos en conflicto..."
  DEBIAN_FRONTEND=noninteractive apt-get remove -y \
    libnvidia-egl-xcb1 libnvidia-egl-xlib1 libnvidia-egl-gbm1 \
    libnvidia-gpucomp-580 nvidia-persistenced 2>&1 | tail -3 || true
  DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-overwrite" \
    --fix-broken install || warn "fix-broken (2) terminó con avisos"
  DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-overwrite" \
    full-upgrade || warn "full-upgrade (2) terminó con avisos"
  dpkg --configure -a || warn "dpkg --configure -a (2) reportó errores"
fi

# ---------------------------------------------------------------------------
# Paso 7: Reconstruir los módulos DKMS para el kernel objetivo
# ---------------------------------------------------------------------------
log "Paso 7: Reconstruir módulos DKMS para $TARGET"
if [[ -d /lib/modules/$TARGET ]]; then
  dkms autoinstall -k "$TARGET" || true
fi
if dkms status 2>/dev/null | grep "nvidia.*, $TARGET" | grep -q "installed"; then
  ok "Módulo nvidia correcto para $TARGET: $(dkms status 2>/dev/null | grep ", $TARGET" | head -1)"
else
  warn "El módulo nvidia para $TARGET NO está construido."
  warn "Revisa: tail -50 /var/lib/dkms/nvidia/*/build/make.log"
fi

# ---------------------------------------------------------------------------
# Paso 8: Reconstruir el initramfs del kernel objetivo
# ---------------------------------------------------------------------------
log "Paso 8: Reconstruir initramfs para $TARGET"
if [[ -d /lib/modules/$TARGET ]]; then
  update-initramfs -c -k "$TARGET" 2>&1 | tail -1 || warn "Fallo al generar initramfs"
  if [[ -f "/boot/initrd.img-$TARGET" ]]; then
    ok "$(ls -la "/boot/initrd.img-$TARGET" | awk '{print $5, $9}')"
  else
    warn "initrd.img-$TARGET no se generó"
  fi
else
  warn "/lib/modules/$TARGET no existe"
fi

# ---------------------------------------------------------------------------
# Paso 9: Regenerar GRUB
# ---------------------------------------------------------------------------
log "Paso 9: Regenerar GRUB"
update-grub 2>&1 | tail -2 || true
ok "GRUB regenerado (arrancará el kernel más reciente = $TARGET)"

# ---------------------------------------------------------------------------
# Paso 10: Verificación final
# ---------------------------------------------------------------------------
log "Paso 10: Verificación final"
echo "  Metapaquete $NV_META:"
dpkg -l "$NV_META" 2>/dev/null | tail -1
echo ""
echo "  Módulos DKMS nvidia:"
dkms status 2>/dev/null | grep nvidia || true
echo ""
echo "  initramfs del target:"
ls -la "/boot/initrd.img-$TARGET" 2>/dev/null || warn "sin initrd.img-$TARGET"
echo ""
echo "============================================================"
echo " Si el metapaquete está en 'ii', el módulo nvidia para"
echo " $TARGET está 'installed', y existe initrd.img-$TARGET,"
echo " reinicia el equipo; el kernel $TARGET debería arrancar"
echo " sin kernel panic."
echo "============================================================"

if [[ ! -f "/boot/initrd.img-$TARGET" ]]; then
  echo ""
  warn "AVISO: el initramfs de $TARGET no está generado."
  warn "Mientras tanto, arranca el kernel $CUR_KERNEL desde"
  warn "'Advanced options for Ubuntu' en el menú de GRUB."
fi
