# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  #source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

export TERMINAL="sterminal"

if type Xorg >/dev/null 2>&1; then
  echo "Xorg exists on this system."
  if [ "$TMUX" = "" ]; then tmux; fi
  export LS_COLORS="$(vivid generate molokai)"
else
  echo "Xorg does not exist on this system."
  export TERM="xterm-256color"
fi

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
export PATH=$HOME/.config/composer/vendor/bin:$PATH
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=/home/herles/.config/composer/vendor/bin/laravel:$PATH
export PATH=/opt/thunderbird:$PATH
export PATH=/opt/android-studio/bin:$PATH
export PATH=/opt/robo3t/bin:$PATH
export PATH=$HOME/.pub-cache/bin:$PATH
# export JAVA_HOME=/usr/local/java/jdk-14.0.2
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

export BAT_THEME="TwoDark"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="asf"
#ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "mortalscumbag" "kolo" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  copypath
  copyfile
  tmux
  history
  colored-man-pages
  jump
  fzf
)

if type Xorg >/dev/null 2>&1; then
  echo "Xorg exists on this system."
else
  echo "Xorg does not exist on this system."
  plugins=(
    git
    zsh-autosuggestions
    zsh-completions
    copypath
    copyfile
    history
    colored-man-pages
    jump
    fzf
  )
fi

autoload -U compinit && compinit
source $ZSH/oh-my-zsh.sh

typeset -ga sources
sources+="$HOME/.dotfiles/oh-my-zsh/aliases.zsh"
sources+="$HOME/.oh-my-zsh/custom/plugins/fzf-tab-completion/zsh/fzf-zsh-completion.sh"
sources+="$HOME/.cargo/env"
# try to include all sources
foreach file (`echo $sources`)
  if [[ -a $file  ]]; then
    source $file
  fi
end

# only aws command completion
zstyle ':completion:*:*:aws' fzf-search-display true
# or for everything
zstyle ':completion:*' fzf-search-display true

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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

eval "$(starship init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/herles/Downloads/ls/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/herles/Downloads/ls/etc/profile.d/conda.sh" ]; then
        . "/home/herles/Downloads/ls/etc/profile.d/conda.sh"
    else
        export PATH="/home/herles/Downloads/ls/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

. ~/.config/z/z.sh

export FZF_BASE=/usr/bin/fzf
alias kubectl="minikube kubectl --"

# export WALLPAPER=sed -n -e '/size/ p' "$(gsettings get org.gnome.desktop.background picture-uri-dark | cut -d/ -f3- | cut -d\' -f1)" | awk -F\> '{ print $2 }' | awk -F\< '{ print $1 }'
