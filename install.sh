#!/usr/bin/env bash

function installAdminTools() {
  echo "Installing admin tools"

  if which nodejs > /dev/null; then
    echo "nodejs is already installed."
  else
    echo "Installing NodeJs..."
    curl -L https://git.io/n-install | bash
  fi

  if which vtop > /dev/null; then
    echo "vtop is already installed."
  else
    echo "Installing vtop..."
    npm i -g vtop
  fi

  if which bat > /dev/null; then
    echo "bat is already installed."
  else
    echo "Installing bat..."
    sudo apt install bat
  fi

  if which tree > /dev/null; then
    echo "tree is already installed."
  else
    echo "Installing tree..."
    sudo apt install tree
  fi

  if [ -f /usr/bin/dfc ]; then
    echo "dfc is already installed"
  else
    echo "Installing dfc..."
    sudo apt-get install dfc
  fi

  if [ -f /usr/bin/vivid ]; then
    echo "vivid is already installed"
  else
    echo "Downloading vivid0.4.0..."
    wget "https://github.com/sharkdp/vivid/releases/download/v0.4.0/vivid_0.4.0_amd64.deb"
    echo "Installing vivid0.4.0..."
    sudo dpkg -i vivid_0.4.0_amd64.deb
  fi

  export LS_COLORS="$(vivid generate snazzy)"
}

function installOhMyZSH() {
  echo "Installing ZSH y git-core..."

  cd ~/
  if which zsh > /dev/null; then
    echo "zsh is already installed."
  else
    echo "Installing zsh"
    sudo apt-get install zsh
  fi

  if which git > /dev/null; then
    echo "Git is already installed."
  else
    echo "Installing git..."
    sudo apt-get install git-core
  fi

  if [ -d ~/.oh-my-zsh ]; then
    if [ -f ~/.oh-my-zsh/themes/asf.zsh-theme ]; then
      rm ~/.oh-my-zsh/themes/asf.zsh-theme
    fi
    cd ~/.oh-my-zsh && git pull;
  else
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
  fi

  if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    cd ~/.oh-my-zsh && git pull;
  else
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  fi

  if [ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
    cd ~/.oh-my-zsh && git pull;
  else
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
  fi

  if [ -d ~/.dotfiles/gruvbox ]; then
    cd ~/.dotfiles/gruvbox && git pull;
  fi

  if [ -f ~/.zshrc ]; then
    rm ~/.zshrc
  fi

  ln -sf ~/.dotfiles/.zshrc ~/.zshrc

  chsh -s `which zsh`
}

function cloneDotfiles() {
  cd ~/

  if [ -d ~/.dotfiles ]; then
    echo "Pulling dotfiles..."
    cd ~/.dotfiles && git checkout && git pull
  else
    echo "Clonning dotfiles..."
    git clone https://github.com/DevHerles/dotfiles.git -b transparent ~/.dotfiles
  fi

  if [ -f ~/.oh-my-zsh/themes/asf.zsh-theme ]; then
    echo "Skipping..., asf.zsh-theme is already installed."
  else
    echo "Linking asf.zsh-theme..."
    ln -sf ~/.dotfiles/asf.zsh-theme ~/.oh-my-zsh/themes/asf.zsh-theme
  fi

  file=".gitconfig"
  if [ -f $file ] ; then
    echo "Removing .gitconfig..."
    rm $file
  fi
  echo "Linking .gitconfig..."
  ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig

  echo "Linking init.vim..."
  ln -sf ~/.dotfiles/init.vim ~/.config/nvim/init.vim

  echo "Linking configs folder..."
  ln -sf ~/.dotfiles/configs ~/.config/nvim/configs
}

function setupVim() {
  echo "Setting up vim and neovim..."
  cd ~/

  if [ -f ~/.config/vim ]; then
    echo "Neovim is already installed"
  else
    echo "Installing Neovim..."
    sudo apt-get install neovim
    sudo apt-get install python-neovim
    sudo apt-get install python3-neovim
  fi

    # Link vimrc for both vim and neovim
    if [ -f ~/.vimrc ]; then
      echo "Removing .vimrc..."
      rm ~/.vimrc
    fi
    echo "Linking .vimrc"
    ln -sf ~/.dotfiles/.vimrc ~/.vimrc

    if [ -f ~/.config/nvim/init.vim ]; then
      echo "Removing init.vim..."
      rm ~/.config/nvim/init.vim
    fi
    echo  "Linking init.vim..."
    ln -sf ~/.dotfiles/init.vim ~/.config/nvim/init.vim

    # Set up colors folder
    mkdir -p ~/.vim/colors
    mkdir -p ~/.config/nvim/colors

    # Install vim-plug
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    local colors=($(ls ~/.dotfiles/vim_colors))
    for colorFile in $colors
    do
      ln -sf ~/.dotfiles/vim_colors/$colorFile ~/.vim/colors/$colorFile
      ln -sf ~/.dotfiles/vim_colors/$colorFile ~/.config/nvim/colors/$colorFile
    done

    echo "Vim and neovim setup complete"
    echo "Once this process is complete open vim and run :PlugInstall"
  }

function setupTmux() {
  echo "Installing tmux plugin manager..."

  if [ -d ~/.tmux/plugins/tpm ]; then
    cd ~/.tmux/plugins/tpm && git pull
  else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  cd ~/
  echo "Linking tmux config"
  file=".tmux.conf"
  if [ -f $file ] ; then
    echo "Removing .tmux.conf..."
    rm $file
  fi
  echo "Linking .tmux.conf..."
  ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
}

function setupDirColors() {
  echo "Setup dircolors..."
  eval $( dircolors -b ~/.dotfiles/dir_colors )
}

function installDocker() {
  if which nodejs > /dev/null; then
    echo "Docker is already installed."
  else
    echo "Installing docker..."
    sudo apt install docker.io
    sudo systemctl start docker
    sudo systemctl enable docker

    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
  fi
}

function install() {
  echo "Beginning Installation..."
  installAdminTools
  installOhMyZSH
  cloneDotfiles
  setupVim
  setupTmux
  installDocker
  setupDirColors
}

install
