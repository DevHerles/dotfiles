#!/usr/bin/env bash

# docker cp init-server.h container_id:/init-server.h

export TERM=xterm-256color

adduser admin
usermod -aG sudo admin

apt install git iputils-ping wget curl -y
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
cd ~/.fzf/
./install

cd $HOME

brew install neovim

alias vi='nvim'
alias vim='nvim'

ssh-keygen -t ed25519 -C "admin@server"
cat ~/.ssh/id_ed25519.pub

mkdir -p /home/admin/.ssh
mv ~/.ssh/id_ed25519 /home/admin/.ssh
mv ~/.ssh/id_ed25519.pub /home/admin/.ssh
chown -R admin:admin /home/admin/.ssh
