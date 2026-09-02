#!/usr/bin/env bash

set -euo pipefail

SSH_DIR="$HOME/.ssh"
SSH_CONFIG="$SSH_DIR/config"
IDENTITY_FILE="$SSH_DIR/id_ed25519"
PUBLIC_KEY="${IDENTITY_FILE}.pub"

echo "=== Agregar servidor SSH ==="
echo

# Verificar que exista la clave
if [[ ! -f "$IDENTITY_FILE" || ! -f "$PUBLIC_KEY" ]]; then
    echo "Error: no existe la clave SSH:"
    echo "  $IDENTITY_FILE"
    echo
    echo "Créala primero con:"
    echo "  ssh-keygen -t ed25519 -f $IDENTITY_FILE"
    exit 1
fi

read -rp "Alias (ej. bastion-dev): " ALIAS
read -rp "IP: " IP
read -rp "Usuario: " USER

if [[ -z "$ALIAS" || -z "$IP" || -z "$USER" ]]; then
    echo "Error: alias, IP y usuario son obligatorios."
    exit 1
fi

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

touch "$SSH_CONFIG"
chmod 600 "$SSH_CONFIG"

# Verificar si el alias ya existe
if grep -qE "^Host[[:space:]]+$ALIAS$" "$SSH_CONFIG"; then
    echo
    echo "Error: el alias '$ALIAS' ya existe en $SSH_CONFIG"
    exit 1
fi

echo
echo "Instalando clave pública en $USER@$IP..."
echo "Se te pedirá la contraseña del servidor una última vez."
echo

ssh-copy-id \
    -i "$PUBLIC_KEY" \
    "$USER@$IP"

echo
echo "Clave instalada correctamente."
echo "Configurando alias SSH..."

cat >> "$SSH_CONFIG" <<EOF

Host $ALIAS
    HostName $IP
    User $USER
    IdentityFile $IDENTITY_FILE
    IdentitiesOnly yes
EOF

echo
echo "Configuración creada:"
echo
echo "Host $ALIAS"
echo "    HostName $IP"
echo "    User $USER"
echo "    IdentityFile $IDENTITY_FILE"
echo

echo "Probando conexión..."
echo

if ssh -o BatchMode=yes "$ALIAS" "echo 'SSH sin contraseña: OK'"; then
    echo
    echo "========================================"
    echo " Servidor configurado correctamente"
    echo "========================================"
    echo
    echo "Conéctate usando:"
    echo
    echo "  ssh $ALIAS"
else
    echo
    echo "ERROR: la conexión sin contraseña no funcionó."
    exit 1
fi
