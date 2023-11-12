#!/usr/bin/env bash

export TERM=xterm-256color

ssh-keygen -t ed25519 -C "admin@server"
sudo apt install git iputils-ping wget -y

cat ~/.ssh/id_ed25519.pub

