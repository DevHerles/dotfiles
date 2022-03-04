# Dotfiles

## About

This repo is a collection of all my dotfiles for vim, tmux and zsh. This repo contains my `.vimrc`, `.tmux.conf` and my `.zshrc`. I also use `oh-my-zsh`

## Installation

To install simply run:
`curl https://raw.githubusercontent.com/DevHerles/dotfiles/master/install/install.sh | bash`

Be sure to also install the font in the `fonts/` folder and use this font as the default for your terminal. Do not use a separate font for non-ascii characters.

Execute:
```bash
export LS_COLORS="$(vivid generate snazzy)"
```

## What Gets Installed

- n (faster nvm alternative)
- node
- vim
- tmux
- zsh
- oh-my-zsh
- Many additionl plugins and packages

zsh will be set to be the default shell. Symlinks will be set up for `.vimrc`, `.tmux.conf` and `.zshrc` and all the themes.

Be sure to install the font in `fonts/`and set this to be the default font for your terminal

### Installing TMUX plugins

1. Add new plugin to `~/.tmux.conf` with `set -g @plugin '...'`
2. Press `prefix` + <kbd>I</kbd> (capital i, as in **I**nstall) to fetch the plugin.

You're good to go! The plugin was cloned to `~/.tmux/plugins/` dir and sourced.

### Uninstalling TMUX plugins

1. Remove (or comment out) plugin from the list.
2. Press `prefix` + <kbd>alt</kbd> + <kbd>u</kbd> (lowercase u as in **u**ninstall) to remove the plugin.

All the plugins are installed to `~/.tmux/plugins/` so alternatively you can
find plugin directory there and remove it.

### Key bindings - TMUX

`prefix` + <kbd>I</kbd>
- Installs new plugins from GitHub or any other git repository
- Refreshes TMUX environment

`prefix` + <kbd>U</kbd>
- updates plugin(s)

`prefix` + <kbd>alt</kbd> + <kbd>u</kbd>
- remove/uninstall plugins not on the plugin list

# Coc settings
## jedi for python2
```bash
sudo pip install -U jedi
```
## jedi for python3
```bash
sudo pip3 install -U jedi
```
## python interpreter
```bash
:CocCommand python.setInterpreter
```


## Installation Notes

Your computer password is needed to change shells which is a sudo operation

## Switching remote URLs from HTTPS to SSH

```bash
git remote set-url origin git@github.com:DevHerles/dotfiles.git
```
