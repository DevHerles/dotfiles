# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  #source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# export TERMINAL="sterminal"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if which brew > /dev/null; then
  echo "brew is already installed."
else
  echo "Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install eza
fi

if [ -e "$HOME/.notgui" ]; then
  export TERM="xterm-256color"

  echo "Welcome to My Linux Server, $(whoami)!"
  echo "This server is running $(lsb_release -d -s)"
  echo "Last login: $(date)"
else  
  if which vivid > /dev/null; then
    echo "vivid is already installed."
  else
    echo "Installing vivid..."
    sudo brew install vivid
  fi
  export LS_COLORS="$(vivid generate molokai)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

if [ "$TMUX" = "" ]; then tmux; fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to your flutter installation.
export PATH=$HOME/.flutter/bin:$PATH
export PATH=/opt/flutter/bin:$PATH
export PATH=$HOME/.flutter/bin/cache/dart-sdk:$PATH
export PATH=/opt/flutter/bin/cache/dart-sdk:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=/usr/lib/dart/bin:$PATH
export PATH=/usr/lib/dart/bin/dartfmt:$PATH
export PATH=/usr/bin/gem:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.dotfiles/bin:$PATH
export PATH=$HOME/.asf:$PATH
export PATH=$HOME/.config/composer/vendor/bin:$PATH
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=/home/herles/.config/composer/vendor/bin/laravel:$PATH
export PATH=/opt/thunderbird:$PATH
export PATH=/opt/android-studio/bin:$PATH
export PATH=/opt/robo3t/bin:$PATH
export PATH=$HOME/.pub-cache/bin:$PATH
export PATH=$HOME/Downloads/apache-maven-3.9.6-bin/apache-maven-3.9.6/bin:$PATH
# export JAVA_HOME=/usr/local/java/jdk-14.0.2
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:/snap/k9s/current/bin:$PATH
export PATH=$PATH:/usr/local/netbeans-12.0/netbeans/bin:$PATH

export BAT_THEME="TwoDark"
ZSH_THEME="asf"
COMPLETION_WAITING_DOTS="true"

autoload -U compinit && compinit
source $ZSH/oh-my-zsh.sh

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

if type Xorg >/dev/null 2>&1; then
  echo "Xorg exists on this system."
else
  # Add in zsh plugins
  zinit light zsh-users/zsh-syntax-highlighting
  zinit light zsh-users/zsh-completions
  zinit light zsh-users/zsh-autosuggestions
  zinit light Aloxaf/fzf-tab
fi

typeset -ga sources
sources+="$HOME/.dotfiles/oh-my-zsh/aliases.zsh"
# sources+="$HOME/.oh-my-zsh/custom/plugins/fzf-tab-completion/zsh/fzf-zsh-completion.sh"
sources+="$HOME/.cargo/env"
# try to include all sources
foreach file (`echo $sources`)
  if [[ -a $file  ]]; then
    source $file
  fi
end

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
echo -e "\e]12;yellow\a"

bindkey '^ ' autosuggest-accept

# eval "$(starship init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. ~/.config/z/z.sh

# export FZF_BASE=/usr/bin/fzf

alias ls="eza --icons=always"
alias l.='ls -d .* --color=auto'
alias trash='mv --force -t ~/.local/share/Trash '
alias count='find . -type f | wc -l'
alias c='clear'

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
