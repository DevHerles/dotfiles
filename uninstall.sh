#!/usr/bin/env bash
function uninstall() {
    sudo rm .zshrc
    sudo rm -rf .dotfiles
    sudo rm .tmux.conf   
    sudo rm -rf .tmux    
    sudo rm -rf .oh-my-zsh 
    sudo rm -rf .powerlevel10k
}

uninstall
