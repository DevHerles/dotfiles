#!/usr/bin/env bash
function uninstall() {
    sudo rm -rf .dotfiles
    sudo rm -rf .tmux
    sudo rm -rf .oh-my-zsh
    sudo rm -rf .powerlevel10k
    sudo rm .zshrc
    sudo rm .vimrc
    sudo rm .tmux.conf
}

uninstall
