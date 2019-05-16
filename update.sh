#!/usr/bin/env bash

rm ~/.vimrc
rm ~/.tmux.conf
rm ~/.zshrc

if [ -d ~/.dotfiles ]; then
    cd ~/.dotfiles && git pull;
else
    git clone https://github.com/DevHerles/dotfiles.git ~/.dotfiles
fi
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
