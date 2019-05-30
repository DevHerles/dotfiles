#!/usr/bin/env bash

function installHomebrew() {

    echo "==================================="
    echo "Installing homebrew"
    echo "==================================="

    cd ~/

    which -s brew > /dev/null
    if [[ $? -eq 1 ]]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        brew upgrade
    fi
}

function installHomebrewPackages() {

    echo "=================================="
    echo "Installing homebrew packages:"
    echo "git"
    echo "neovim"
    echo "tmux"
    echo "zsh"
    echo "fzf"
    echo "bat"
    echo "icdiff"
    echo "shpotify"
    echo "=================================="

    cd ~/

    brew install git
    brew install neovim
    brew install tmux
    brew install zsh
    brew install fzf
    brew install bat
    brew install icdiff
    brew install shpotify

    # Sneak on colorls here --> https://github.com/athityakumar/colorls
    gem install colorls
}

function installNodeJS() {

    echo "==================================="
    echo "Installing n and NodeJS"
    echo "==================================="

    cd ~/

    curl -L https://git.io/n-install | bash
}

function installNpmPackages() {

    echo "==================================="
    echo "Installing global npm packages"
    echo "vtop"
    echo "==================================="

    cd ~/

    npm i -g vtop
}

function installToos() {

    echo "==================================="
    echo "Installing admin tools"
    echo "dfc"
    echo "==================================="

    sudo apt-get install dfc
}

function installOhMyZSH() {

    echo "==================================="
    echo "Installing ZSH y git-core"
    echo "zsh"
    echo "git-core"
    echo "==================================="

    cd ~/
    sudo apt-get install zsh
    sudo apt-get install git-core

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
    # git clone https://github.com/commanderkelso/oh-my-zsh-gruvbox-powerline-theme.git
    # mv ~/oh-my-zsh-gruvbox-powerline-theme ~/.dotfiles/gruvbox/
    # rm ~/.oh-my-zsh/themes/gruvbox-powerline.zsh-theme
    # ln -s ~/.dotfiles/gruvbox/gruvbox-powerline.zsh-theme ~/.oh-my-zsh/themes

    ln -sf ~/.dotfiles/.zshrc ~/.zshrc

    chsh -s `which zsh`

}
function cloneDotfiles() {

    echo "==================================="
    echo "Cloning dotfiles"
    echo "==================================="

    cd ~/

    if [ -d ~/.dotfiles ]; then
        rm -rf ~/.dotfiles
    fi

    git clone https://github.com/DevHerles/dotfiles.git ~/.dotfiles

    cp ~/.dotfiles/asf.zsh-theme ~/.oh-my-zsh/themes/
    # echo "Installing z.sh"
    # git clone https://github.com/rupa/z.git ~/

    # Create secret keys file - used to store local env vars
    # touch ~/dotfile/secret-keys.sh
}

function setupVim() {
    echo "==================================="
    echo "Setting up vim and neovim"
    echo "==================================="

    cd ~/

    # Link vimrc for both vim and neovim
    if [ -f ~/.vimrc ]; then
        rm ~/.vimrc
    fi
    if [ -f ~/.config/nvim/init.vim ]; then
        rm ~/.config/nvim/init.vim
    fi
    ln -sf ~/.dotfiles/.vimrc ~/.vimrc
    ln -sf ~/.dotfiles/.vimrc ~/.config/nvim/init.vim

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

    echo "==================================="
    echo "Vim and neovim setup complete"
    echo "Once this process is complete open vim and run :PlugInstall"
    echo "==================================="

}

function setupTmux() {
    echo "==================================="
    echo "Installing tmux plugin manager"
    echo "==================================="

    if [ -d ~/.tmux/plugins/tpm ]; then
       cd ~/.tmux/plugins/tpm && git pull
    else
       git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    cd ~/
    echo "==================================="
    echo "Linking tmux config"
    echo "==================================="
    file=".tmux.conf"
    if [ -f $file ] ; then
        rm $file
    fi
    ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
}

function install() {

    echo "==================================="
    echo "Beginning Installation..."
    echo "==================================="

    # installHomebrew
    # installHomebrewPackages
    # installNodeJS
    # installNpmPackages
    installToos
    installOhMyZSH
    cloneDotfiles
    setupVim
    setupTmux
}

install
