export EDITOR="nvim"

alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vif='nvim $(fzf)'
alias ivf='nvim $(fzf)'

alias cd=' cd'
alias ..=' cd ..; ls'
alias ...=' cd ..; cd ..; ls'
alias ....=' cd ..; cd ..; cd ..; ls'
alias cd..='..'
alias cd...='...'
alias cd....='....'

alias go='git checkout'
alias gst='git status'

alias cls='clear'

alias glop="git log --graph --pretty=format:'%C(#d79921)%h%Creset -%C(yellow)%d%Creset %C(#83a598)%s%Creset %C(#fe8019)(%cr) %C(#665c54)<%an>%Creset' --abbrev-commit --date=relative"
alias glo="git log --oneline --pretty=format:'%C(#d79921)%h%Creset -%C(yellow)%d%Creset %C(#83a598)%s%Creset %C(#fe8019)(%cr) %C(#665c54)<%an>%Creset' --abbrev-commit --date=relative"
alias gpf="git add . & git commit --amend --no-edit & git push -f"
alias gca="git add . & git commit --amend --no-edit"
alias gdf="git diff"

alias dcu="docker-compose up"
alias dcs="docker-compose stop"
alias dcr="docker-compose restart"
alias dcd="docker-compose run --service-ports web"
alias j=jump

alias open=xdg-open
alias vs="vim ~/.config/sxhkd/sxhkdrc"
alias vb="vim ~/.config/bspwm/bspwmrc"
alias vp="vim ~/.config/polybar/config"
alias logout="kill -9 -1"

alias fzf="fzf --height 70% --layout reverse --info inline --border \
    --preview 'bat --style=numbers --color=always --line-range :500 {}' --bind 'alt-j:down,alt-k:up,alt-8:preview-down,alt-9:preview-up' --preview-window right:60%:noborder \
    --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'"

alias rs="cd ~/asfdev/devherles/rasa-projects/rasa-symptoms && source ~/asfdev/devherles/rasa-projects/rasa-env/bin/activate"
