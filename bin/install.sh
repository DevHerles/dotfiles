#!/usr/bin/env bash
set -euo pipefail

# =============================================
# Helpers
# =============================================

log()  { printf "\n\033[1;34m== %s ==\033[0m\n" "$*"; }
ok()   { printf "\033[0;32m  ✓ %s\033[0m\n" "$*"; }
info() { printf "\033[0;33m  ➜ %s\033[0m\n" "$*"; }

is_installed() { command -v "$1" >/dev/null 2>&1; }

# ensure <cmd> <install_command...>
ensure() {
  local bin="$1"; shift
  if is_installed "$bin"; then
    ok "$bin"
  else
    info "Instalando $bin..."
    "$@"
  fi
}

# ensure_git <dir> <subcommand_when_exists> <repo>
ensure_git() {
  local dir="$1"; shift
  if [[ -d "$dir" ]]; then
    ok "$dir"
    if [[ -n "${1:-}" ]]; then
      (cd "$dir" && "${@}")
    fi
  else
    info "Clonando $1..."
    git clone --depth 1 "$2" "$dir"
  fi
}

is_server() { [[ -f "$HOME/.notgui" ]]; }

# =============================================
# Admin tools
# =============================================

function installAdminTools() {
  log "Instalando herramientas administrativas"

  local apt_pkgs=(
    "neofetch:neofetch"
    "xclip:xclip"
    "htop:htop"
    "ranger:ranger"
    "tree:tree"
    "xsel:xsel"
    "ack:ack-grep"
    "bat:bat"
  )

  for entry in "${apt_pkgs[@]}"; do
    local bin="${entry%%:*}"
    local pkg="${entry##*:}"
    if ! is_installed "$bin"; then
      info "Instalando $pkg..."
      sudo apt-get install -y "$pkg"
      if [[ "$bin" == "bat" ]]; then
        mkdir -p "$HOME/.local/bin"
        ln -sf /usr/bin/batcat "$HOME/.local/bin/bat"
      fi
    else
      ok "$pkg"
    fi
  done

  # net-tools (netstat lives in /bin/netstat)
  if ! is_installed netstat; then
    info "Instalando net-tools..."
    sudo apt-get install -y net-tools
  else
    ok "net-tools"
  fi

  if ! is_installed ctags; then
    info "Instalando ctags..."
    sudo apt-get install -y universal-ctags || sudo apt-get install -y ctags
  else
    ok "ctags"
  fi

  if ! is_installed dfc; then
    info "Instalando dfc..."
    sudo apt-get install -y dfc || true
  else
    ok "dfc"
  fi

  # brew tools
  if is_installed brew; then
    local brew_pkgs=(
      "lazygit:lazygit"
      "stylua:stylua"
      "vivid:vivid"
    )
    for entry in "${brew_pkgs[@]}"; do
      local bin="${entry%%:*}"
      local pkg="${entry##*:}"
      if ! is_installed "$bin"; then
        info "Instalando $pkg (brew)..."
        brew install "$pkg"
      else
        ok "$pkg"
      fi
    done
  else
    info "brew no disponible, saltando lazygit, stylua y vivid"
  fi

  if is_installed vivid; then
    local colors
    colors="$(vivid generate snazzy)"
    export LS_COLORS="$colors"
  fi
}

# =============================================
# Starship
# =============================================

function installStarship() {
  log "Instalando Starship"
  if is_installed starship; then
    ok "starship"
  else
    info "Instalando starship..."
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
  fi
}

# =============================================
# Oh My ZSH
# =============================================

function installOhMyZSH() {
  log "Instalando Oh My ZSH"

  if ! is_installed zsh; then
    info "Instalando zsh..."
    sudo apt-get install -y zsh git-core
  else
    ok "zsh"
  fi

  ensure_git ~/.oh-my-zsh "git pull" https://github.com/ohmyzsh/ohmyzsh.git

  rm -f ~/.oh-my-zsh/themes/asf.zsh-theme

  ensure_git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
    "git pull" https://github.com/zsh-users/zsh-autosuggestions.git
  ensure_git ~/.oh-my-zsh/custom/plugins/zsh-completions \
    "git pull" https://github.com/zsh-users/zsh-completions.git

  mkdir -p ~/.config
  ensure_git ~/.config/z "git pull" git@github.com:rupa/z.git

  mkdir -p ~/.config/ranger/plugins
  ensure_git ~/.config/ranger/plugins/ranger_devicons \
    "git pull" https://github.com/alexanderjeurissen/ranger_devicons.git

  if [[ -d ~/.dotfiles/gruvbox ]]; then
    (cd ~/.dotfiles/gruvbox && git pull)
  fi

  ln -sf ~/.dotfiles/zshrc ~/.zshrc

  if [[ "$SHELL" != */zsh ]]; then
    info "Cambiando shell por defecto a zsh..."
    chsh -s "$(command -v zsh)"
  else
    ok "zsh es la shell actual"
  fi
}

# =============================================
# Tmux
# =============================================

function setupTmux() {
  if ! is_installed Xorg; then
    info "Xorg no detectado, saltando tmux"
    return
  fi

  log "Configurando tmux"

  if ! is_installed tmux; then
    info "Instalando tmux..."
    sudo apt-get install -y tmux
  else
    ok "tmux"
  fi

  ensure_git ~/.tmux/plugins/tpm "git pull" https://github.com/tmux-plugins/tpm

  ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
}

# =============================================
# Dircolors
# =============================================

function setupDirColors() {
  log "Configurando dircolors"
  eval "$(dircolors -b ~/.dotfiles/dir_colors)"
}

# =============================================
# Dotfiles symlinks
# =============================================

function linkingDotFiles() {
  log "Creando enlaces simbólicos"

  local links=(
    "$HOME/.dotfiles/asf.zsh-theme:$HOME/.oh-my-zsh/themes/asf.zsh-theme"
    "$HOME/.dotfiles/gitconfig:$HOME/.gitconfig"
    "$HOME/.dotfiles/alacritty.yml:$HOME/.alacritty.yml"
    "$HOME/.dotfiles/config/ranger/rc.conf:$HOME/.config/ranger/rc.conf"
    "$HOME/.dotfiles/config/ranger/colorschemes:$HOME/.config/ranger/colorschemes"
    "$HOME/.dotfiles/ssh-config:$HOME/.ssh/config"
  )

  mkdir -p "$HOME/.oh-my-zsh/themes" "$HOME/.config/ranger" "$HOME/.ssh"

  for entry in "${links[@]}"; do
    local src="${entry%%:*}"
    local dst="${entry##*:}"
    ln -sf "$src" "$dst"
    ok "$(basename "$src") → $dst"
  done
}

# =============================================
# AppArmor
# =============================================

function enableAppArmor() {
  log "Habilitando AppArmor"
  sudo systemctl start apparmor.service
}

# =============================================
# Fonts
# =============================================

function installNerdFont() {
  log "Instalando fuente JetBrainsMono"
  mkdir -p "$HOME/.local/share/fonts"
  wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
  unzip -o -q JetBrainsMono.zip -d "$HOME/.local/share/fonts"
  rm -f JetBrainsMono.zip
  fc-cache -f "$HOME/.local/share/fonts"
  ok "Fuente instalada"
}

# =============================================
# FZF
# =============================================

function installFzf() {
  log "Instalando fzf"
  ensure_git ~/.fzf "" https://github.com/junegunn/fzf.git
  ~/.fzf/install --all --no-update-rc
}

# =============================================
# GUI tools
# =============================================

function guiTools() {
  if ! is_installed Xorg; then
    info "Xorg no detectado, saltando tools GUI"
    return
  fi

  log "Instalando tools GUI"

  # Ruby via apt
  if ! is_installed ruby; then
    info "Instalando ruby..."
    sudo apt-get install -y ruby-full
  else
    ok "ruby"
  fi

  # Node via apt
  if ! is_installed node; then
    info "Instalando nodejs..."
    sudo apt-get install -y nodejs
  else
    ok "nodejs"
  fi

  # NPM
  if ! is_installed npm; then
    info "Instalando npm..."
    sudo apt-get install -y npm
  else
    ok "npm"
  fi

  # Python tools
  if ! is_installed pip3; then
    info "Instalando pip3..."
    sudo apt-get install -y python3-pip
  else
    ok "pip3"
  fi

  local pip_pkgs=(jedi black isort ueberzug pywal)
  for pkg in "${pip_pkgs[@]}"; do
    info "Instalando $pkg (pip)..."
    sudo pip3 install -U "$pkg"
  done

  # Brew
  if ! is_installed brew; then
    info "Instalando brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bash_profile"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    ok "brew"
  fi

  # Imagemagick
  if ! is_installed imagemagick; then
    info "Instalando imagemagick..."
    sudo apt-get install -y imagemagick
  else
    ok "imagemagick"
  fi

  # vtop (needs npm)
  if ! is_installed vtop && is_installed npm; then
    info "Instalando vtop..."
    sudo npm i -g vtop
  else
    ok "vtop"
  fi
}

# =============================================
# Bin scripts
# =============================================

function installBinScripts() {
  log "Instalando scripts a /usr/local/bin"
  sudo cp ~/.dotfiles/bin/*.sh /usr/local/bin/
  sudo chmod +x /usr/local/bin/*.sh
  ok "Scripts instalados: $(find /usr/local/bin -maxdepth 1 -name '*.sh' -printf '%f ')"
}

# =============================================
# Main
# =============================================

function install() {
  log "Comenzando instalación"
  installAdminTools
  installOhMyZSH
  installStarship
  setupTmux
  linkingDotFiles
  setupDirColors
  enableAppArmor
  installNerdFont
  installFzf
  guiTools
  installBinScripts
  log "Instalación completada"
}

install
