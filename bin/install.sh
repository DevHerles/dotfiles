#!/usr/bin/env bash

function installAdminTools() {
  echo "Installing admin tools"
  sudo apt install libxext-dev build-essential iputils-ping wget -y

  if which curl > /dev/null; then
    echo "curl is already installed."
  else
    echo "Installing curl..."
    sudo apt update
    sudo apt upgrade
    sudo apt install curl -y
  fi

  if which imagemagick > /dev/null; then
    echo "imagemagick is already installed."
  else
    echo "Installing imagemagick..."
    sudo apt-get install imagemagick -y
  fi

  if which neofetch > /dev/null; then
    echo "neofetch is already installed."
  else
    echo "Installing neofetch..."
    sudo apt-get install neofetch -y
  fi
  if which pip3 > /dev/null; then
    echo "pip3 is already installed."
  else
    echo "Installing pip3..."
    sudo apt-get install python3-pip -y
    sudo pip3 install -U jedi
    sudo pip3 install black
    sudo pip3 install isort
    sudo pip3 install ueberzug
    sudo pip3 install pywal
  fi

  if which xclip > /dev/null; then
    echo "xclip is already installed."
  else
    echo "Installing xclip..."
    sudo apt-get install xclip -y
  fi

  if which htop > /dev/null; then
    echo "htop is already installed."
  else
    echo "Installing htop..."
    sudo apt-get install htop -y
  fi

  if which ranger > /dev/null; then
    echo "ranger is already installed."
  else
    echo "Installing ranger..."
    sudo apt-get install ranger -y
  fi

  if which netstat > /dev/null; then
    echo "net-tools are already installed."
  else
    echo "Installing net-tools..."
    sudo apt-get install net-tools -y
  fi

  if which ctags > /dev/null; then
    echo "ctags is already installed."
  else
    echo "Installing ctags..."
    sudo apt-get install ctags -y
  fi

  if which xsel > /dev/null; then
    echo "xsel is already installed."
  else
    echo "Installing xsel..."
    sudo apt-get install xsel -y
  fi

  if which ruby > /dev/null; then
    echo "ruby is already installed."
  else
    echo "Installing ruby..."
    sudo apt-get install ruby-full -y
  fi

  if which brew > /dev/null; then
    echo "brew is already installed."
  else
    echo "Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bash_profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi

  if which lazygit > /dev/null; then
    echo "lazygit is already installed."
  else
    echo "Installing lazygit..."
    brew install lazygit
  fi

  if which stylua > /dev/null; then
    echo "stylua is already installed."
  else
    echo "Installing stylua..."
    brew install stylua
  fi

  if which ack > /dev/null; then
    echo "Ack is already installed."
  else
    echo "Installing ack-grep..."
    sudo apt-get install ack-grep -y
  fi

  if which npm > /dev/null; then
    echo "npm is already installed."
  else
    echo "Installing npm..."
    sudo apt install npm -y
    sudo npm install -g neovim
  fi

  if which node > /dev/null; then
    echo "nodejs is already installed."
  else
    echo "Installing NodeJs..."
    sudo apt install nodejs -y
  fi
  
  if which OpenBoard > /dev/null; then
    echo "OpenBoard is already installed."
  else
    echo "Installing OpenBoard..."
    sudo apt install openboard -y
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
    sudo apt-get install bat -y
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
  fi

  if which tree > /dev/null; then
    echo "tree is already installed."
  else
    echo "Installing tree..."
    sudo apt install tree -y
  fi

  if [ -f /usr/bin/dfc ]; then
    echo "dfc is already installed"
  else
    echo "Installing dfc..."
    sudo apt-get install dfc -f
  fi

  if which mdp > /dev/null; then
    echo "mdp is already installed"
  else
    echo "Installing mpd..."
    git clone https://github.com/visit1985/mdp.git /tmp/mdp
    cd /tmp/mdp && make && sudo make install
    rm -rf /tmp/mdp
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

function installStarship() {
  if which starship > /dev/null; then
    echo "starship is already installed"
  else
    echo "Installing starship..."
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
  fi
}


function installOhMyZSH() {
  echo "Installing ZSH y git-core..."

  cd ~/
  if which zsh > /dev/null; then
    echo "zsh is already installed."
  else
    echo "Installing zsh"
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

  if [ -d ~/.config ]; then
    echo "~/.config folder already exists..."
  else
    mkdir ~/.config
  fi

  if [ -d ~/.config/z ]; then
    cd ~/.config/z && git pull;
  else
    git clone git@github.com:rupa/z.git ~/.config/z
  fi

  if [ -d ~/.config/ranger ]; then
    echo "~/.config/ranger folder already exists..."
  else
    mkdir -p ~/.config/ranger/plugins
  fi

  if [ -d ~/.config/ranger/plugins/ranger_devicons ]; then
    echo "ranger_devicons already installed..."
    cd ~/.config/ranger/plugins/ranger_devicons && git pull
  else
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
  fi

  if [ -d ~/.dotfiles/gruvbox ]; then
    cd ~/.dotfiles/gruvbox && git pull;
  fi

  if [ -f ~/.zshrc ]; then
    rm ~/.zshrc
  fi

  ln -sf ~/.dotfiles/zshrc ~/.zshrc

  if [ $SHELL == "/usr/bin/zsh" ]; then
    echo "Skipping, your current console is already zsh..."
  else
    echo "Changing console to zsh..."
    chsh -s `which zsh`
  fi
}

function setupTmux() {
  if which tmux > /dev/null; then
    echo "tmux is already installed."
  else
    echo "Installing tmux..."
    sudo apt install tmux -y
  fi

  echo "Installing tmux plugin manager..."
  if [ -d ~/.tmux/plugins/tpm ]; then
    cd ~/.tmux/plugins/tpm && git pull
  else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  cd ~/
  echo "Linking tmux.conf..."
  ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
}

function setupDirColors() {
  echo "Setup dircolors..."
  eval $( dircolors -b ~/.dotfiles/dir_colors )
}

function linkingDotFiles() {
  cd ~/

  echo "Linking asf.zsh-theme..."
  ln -sf ~/.dotfiles/asf.zsh-theme ~/.oh-my-zsh/themes/asf.zsh-theme

  echo "Linking gitconfig..."
  ln -sf ~/.dotfiles/gitconfig ~/.gitconfig

  echo "Linking alacritty..."
  ln -sf ~/.dotfiles/alacritty.yml ~/.alacritty.yml

  echo "Linking ranger..."
  ln -sf ~/.dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
  ln -sf ~/.dotfiles/config/ranger/colorschemes ~/.config/ranger/colorschemes
}

function enableAppArmor() {
    sudo systemctl start apparmor.service
}

function installNerdFont ()
{
  echo "Installing JetBrainsMono font"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip 
  mkdir -p ~/.local/share/fonts
  unzip JetBrainsMono.zip -d ~/.local/share/fonts
  fc-cache ~/.local/share/fonts
  echo "Done"
}

function install() {
  echo "Beginning installation..."
  installAdminTools
  installOhMyZSH
  installStarship
  setupTmux
  linkingDotFiles
  setupDirColors
  enableAppArmor
  installNerdFont
  echo "End installation..."
}

install
