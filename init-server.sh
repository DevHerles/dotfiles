#!/usr/bin/env bash

# docker cp init-server.h container_id:/init-server.h

export TERM=xterm-256color

# Check if the current user is root
if [ "$(id -u)" -eq 0 ]; then
    echo "Root user detected. Installing Zsh..."
    apt-get update -y
    apt install git iputils-ping wget curl sudo zsh build-essential -y

    adduser admin
    usermod -aG sudo admin

    ssh-keygen -t ed25519 -C "admin@server"
    cat ~/.ssh/id_ed25519.pub

    mkdir -p /home/admin/.ssh
    mv ~/.ssh/id_ed25519 /home/admin/.ssh
    mv ~/.ssh/id_ed25519.pub /home/admin/.ssh

    chown -R admin:admin /home/admin/.ssh
    cp init-server.sh /home/admin/init-server.sh
    chmod +x /home/admin/init-server.sh

    chown admin:admin /home/admin/init-server.sh
else
    echo "Non-root user detected. Installing admin tools..."
    cd $HOME
    echo "Zsh installed and set as the default shell."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s $(which zsh)

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/admin/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    brew install gcc
    brew install neovim

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    cd ~/.fzf/
    ./install

fi

