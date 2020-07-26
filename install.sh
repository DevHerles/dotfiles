#!/usr/bin/env bash

function installFlutter() {
  if which flutter > /dev/null; then
    echo "flutter is already installed."
  else
    echo "Installing flutter..."
    git clone https://github.com/flutter/flutter.git -b stable --depth 1 $HOME
  fi

  if which adb > /dev/null; then
    echo "adb are already installed."
  else
    echo "Installing adb..."
    sudo apt-get install adb
    sudo usermod -aG plugdev $LOGNAME
  fi
}

function installPostgresql() {
  if which psql > /dev/null; then
    echo "postgresql is already installed."
  else
    sudo apt update
    echo "Installing postgresql..."
    sudo apt install postgresql postgresql-contrib
  fi
}

function installAdminTools() {
  echo "Installing admin tools"

  if which curl > /dev/null; then
    echo "curl is already installed."
  else
    echo "Installing curl..."
    sudo apt update
    sudo apt upgrade
    sudo apt install curl
  fi

  if which pip > /dev/null; then
    echo "pip is already installed."
  else
    echo "Installing pip..."
    curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
    sudo python2 get-pip.py
    rm get-pip.py
    pip install --user jedi
    pip install --user pep8
  fi

  if which pip3 > /dev/null; then
    echo "pip3 is already installed."
  else
    echo "Installing pip3..."
    sudo apt-get install python3-pip
    sudo pip3 install -U jedi
    sudo pip3 install black
    sudo pip3 install isort
  fi

  if which xclip > /dev/null; then
    echo "xclip is already installed."
  else
    echo "Installing xclip..."
    sudo apt-get install xclip
  fi

  if which htop > /dev/null; then
    echo "htop is already installed."
  else
    echo "Installing htop..."
    sudo apt-get install htop
  fi

  if which ranger > /dev/null; then
    echo "ranger is already installed."
  else
    echo "Installing ranger..."
    sudo apt-get install ranger
  fi

  if which netstat > /dev/null; then
    echo "net-tools are already installed."
  else
    echo "Installing net-tools..."
    sudo apt-get install net-tools
  fi

  if which ctags > /dev/null; then
    echo "ctags is already installed."
  else
    echo "Installing ctags..."
    sudo apt-get install ctags
  fi

  if which xsel > /dev/null; then
    echo "xsel is already installed."
  else
    echo "Installing xsel..."
    sudo apt-get install xsel
  fi

  if which ruby > /dev/null; then
    echo "ruby is already installed."
  else
    echo "Installing ruby..."
    sudo apt-get install ruby-full
  fi

  if which lazygit > /dev/null; then
    echo "lazygit is already installed."
  else
    echo "Installing lazygit..."
    sudo add-apt-repository ppa:lazygit-team/release
    sudo apt-get update
    sudo apt-get install lazygit
  fi

  if which lazydocker > /dev/null; then
    echo "lazydocker is already installed."
  else
    echo "Installing lazydocker..."
    wget https://github.com/jesseduffield/lazydocker/releases/download/v0.9/lazydocker_0.9_Linux_x86_64.tar.gz
    tar xvzf lazydocker*.tar.gz
    sudo install lazydocker /usr/local/bin
    rm lazydocker*
    rm -rf lazydocker
  fi

  if which ack > /dev/null; then
    echo "Ack is already installed."
  else
    echo "Installing ack-grep..."
    sudo apt-get install ack-grep
  fi

  if which npm > /dev/null; then
    echo "npm is already installed."
  else
    echo "Installing npm..."
    sudo apt install npm
    sudo npm install -g neovim
    sudo npm install -g js-beautify
  fi

  if which node > /dev/null; then
    echo "nodejs is already installed."
  else
    echo "Installing NodeJs..."
    sudo apt install nodejs
  fi

  if which vtop > /dev/null; then
    echo "vtop is already installed."
  else
    echo "Installing vtop..."
    sudo npm i -g vtop
  fi

  if which bat > /dev/null; then
    echo "bat is already installed."
  else
    echo "Installing bat..."
    wget https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb
    sudo dpkg -i bat_0.11.0_amd64.deb && rm bat_0.11.0_amd64.deb
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

  if [ $SHELL == "/usr/bin/zsh" ]; then
    echo "Skipping, your current console is already zsh..."
  else
    echo "Changing console to zsh..."
    chsh -s `which zsh`
  fi
}

function linkingDotFiles() {
  cd ~/

  echo "Linking asf.zsh-theme..."
  ln -sf ~/.dotfiles/asf.zsh-theme ~/.oh-my-zsh/themes/asf.zsh-theme

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

  if which nvim > /dev/null; then
    echo "Neovim is already installed"
  else
    echo "Installing Neovim..."
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim
    sudo apt-get install python-dev python-pip python3-dev python3-pip
    sudo apt-get install python-neovim
    sudo apt-get install python3-neovim
    sudo gem install neovim
  fi

    # Set up colors folder
    mkdir -p ~/.vim/colors
    mkdir -p ~/.config/nvim/colors

    # Install vim-plug
    if [ -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
      echo "Vim-plug is already installed"
    else
      echo "Installing vim-plug..."
      curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      echo "Once this process is complete open vim and run :PlugInstall"
    fi

    local colors=($(ls ~/.dotfiles/vim_colors))
    for colorFile in $colors
    do
      ln -sf ~/.dotfiles/vim_colors/$colorFile ~/.vim/colors/$colorFile
      ln -sf ~/.dotfiles/vim_colors/$colorFile ~/.config/nvim/colors/$colorFile
    done

    echo "Vim and neovim setup complete"
  }

function setupTmux() {
  if which tmux > /dev/null; then
    echo "tmux is already installed."
  else
    echo "Installing tmux..."
    sudo apt install tmux
  fi

  echo "Installing tmux plugin manager..."
  if [ -d ~/.tmux/plugins/tpm ]; then
    cd ~/.tmux/plugins/tpm && git pull
  else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  cd ~/
  echo "Linking .tmux.conf..."
  ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
}

function setupDirColors() {
  echo "Setup dircolors..."
  eval $( dircolors -b ~/.dotfiles/dir_colors )
}

function installDocker() {
  if which docker > /dev/null; then
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
  if which docker-compose > /dev/null; then
    echo "docker-compose is already installed."
  else
    echo "Installing docker-compose..."
    sudo apt install docker-compose
  fi
}

function install() {
  echo "Beginning installation..."
  installAdminTools
  installPostgresql
  installFlutter
  installOhMyZSH
  setupVim
  setupTmux
  linkingDotFiles
  installDocker
  setupDirColors
  echo "End installation..."
}

install
