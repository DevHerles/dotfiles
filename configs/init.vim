"  _   __
" | | / /
" | |/ / _   _  ___ ____
" |    \| | | |/ _ \_  /  Author: Kyoz
" | |\  \ |_| | (_) / /   Github: github.com/banminkyoz
" \_| \_/\__, |\___/___|  Email : banminkyoz@gmail.com
"         __/ |
"        |___/

call plug#begin('~/.config/nvim/plugged') "---------------------- Start vim plug

" VIM-CODEFMT {{{

Plug 'google/vim-codefmt'
Plug 'google/vim-maktaba' "----------Add maktaba and codefmt to the runtimepath.
Plug 'google/vim-codefmt' "-(The latter must be installed before it can be used.)
Plug 'google/vim-glaive' "-----Is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.

" }}}

" VIM-FLOATERM {{{

Plug 'voldikss/vim-floaterm'

" }}}

" VISTA {{{

Plug 'liuchengxu/vista.vim'

" }}}

" VIM-JSON {{{

Plug 'elzr/vim-json'

" }}}

" VIM-MUNDO {{{

Plug 'simnalamburt/vim-mundo'

" }}}

" DART, FLUTTER {{{

Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'

" }}}

" DART, FLUTTER {{{

Plug 'terryma/vim-expand-region'

" }}}

" DENITE {{{

"if has('nvim')
  "Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
"else
  "Plug 'Shougo/denite.nvim'
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
"endif

" }}}

" COLORS, THEMES {{{

Plug 'joshdick/onedark.vim'
Plug 'DevHerles/aranda', { 'rtp': 'vim' }

" }}}

" TOOLBAR {{{

Plug 'bling/vim-airline' "---------------------------------- Status bar, Tabline
Plug 'vim-airline/vim-airline-themes' "- Vim-Airline Themes (To use tabline ext)
Plug 'tpope/vim-fugitive' "---------- Just use to show git status in Vim-Airline

" }}}

" FINDER {{{

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' "-------------------------------------------- fzf in vim

" }}}

" RANGER {{{

Plug 'francoiscabrol/ranger.vim' "----------Ranger integration in vim and neovim
if has('nvim')
  Plug 'rbgrouleff/bclose.vim' "---For neovim, dependency to the plugin bclose.vim
endif

" }}}

" NAVIGATE {{{

Plug 'scrooloose/nerdtree' "------------------------------------------ Nerd Tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "-- Nerdtree syntax & Icon colors
Plug 'ryanoasis/vim-devicons' "------------------------------------------- Icons
Plug 'easymotion/vim-easymotion' "----------- Jump around the screen like a boss
Plug 'andymass/vim-matchup' "------------- Better % and highlight matching words
Plug 'tommcdo/vim-exchange' "-------------------------------- Easy text exchange
Plug 'rhysd/clever-f.vim' "-------------------------------- Make f more powerful

" }}}

" SYNTAX HIGHTLIGHT {{{

Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }"  Typescript's Syntax

" Help colorize text color
Plug 'ap/vim-css-color', {
      \ 'for': [
      \ 'html',
      \ 'css',
      \ 'scss',
      \ 'sass',
      \ 'less'
      \ ] }
Plug 'Valloric/MatchTagAlways' "------- Always highlights the XML/HTML tags that enclose your cursor location
Plug 'MTDL9/vim-log-highlighting', {'for': 'log'} "----------------- For Vim Log

" Frameworks
Plug 'MaxMEllon/vim-jsx-pretty' "----------------------------------------- React

" }}}

" FASTER CODE {{{

Plug 'tmsvg/pear-tree' "------------------------------------- Auto pair brackets
Plug 'alvan/vim-closetag' "--------------------------------- Auto close html tag
Plug 'tpope/vim-surround' "--------------------------------------- Auto surround
Plug 'tpope/vim-commentary' "------------------------------- Comment code faster
Plug 'tpope/vim-repeat' "------------------------------ dot repeat with pluggins
Plug 'Yggdroot/indentLine' "---------------------------- Indent code with v-line
Plug 'wellle/targets.vim' "--------------------- Provides additional text object
Plug 'mg979/vim-visual-multi' "--------------------------------- Multiple Cursor
Plug 'mattn/emmet-vim' "------------------------------------------ Emmet for vim

" }}}

" BEAUTIFY CODE {{{

Plug 'FooSoft/vim-argwrap' "------ Wrap and unwrap function args, list, dicts...
Plug 'prettier/vim-prettier', {
      \ 'do': 'npm install',
      \ 'branch': 'release/1.x',
      \ 'for': [
      \ 'javascript',
      \ 'typescript',
      \ 'css',
      \ 'less',
      \ 'sass',
      \ 'scss',
      \ 'json',
      \ 'markdown',
      \ 'html' ] }

" }}}

" UTILS {{{

Plug 'NLKNguyen/copy-cut-paste.vim' "---------------- Copy, Paste with Clipboard
Plug 'skywind3000/asyncrun.vim' "--------------- Run async shell commands in vim
Plug 'kyoz/ezbuf.vim' "------------------------------- Fast and easy use buffers
Plug 'kyoz/npm.vim' "-------------------------- Work with npm more easier in Vim
Plug 'segeljakt/vim-silicon'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
Plug 'godlygeek/tabular', {'for': 'markdown'} "-------------- Alignment for text
Plug 'dhruvasagar/vim-table-mode',{'for': 'markdown', 'do': ':TableFormat'}
Plug 'lervag/vimtex', {'for': 'tex'} "------------------- For editing Latex file

" Performance
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }
Plug 'tweekmonster/startuptime.vim', {'on': 'StartupTime'}

" Colors
Plug 'KabbAmine/vCoolor.vim' "------------------------------------- Color picker
Plug 'guns/xterm-color-table.vim'

" Focus
Plug 'junegunn/goyo.vim' "---------------------- Distraction-free writing in Vim
Plug 'junegunn/limelight.vim' "----------------------- Hyperfocus-writing in Vim
Plug 'RRethy/vim-illuminate' "--- Auto highlight other uses of word under cursor

" Searching
Plug 'voldikss/vim-search-me' "------------------------ Search google within vim

" }}}

" AUTOCOMPLETE {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" }}}

" TMUX {{{

Plug 'christoomey/vim-tmux-navigator'

" }}}

" ACK {{{

Plug 'mileszs/ack.vim' " ------------Don't forget: sudo apt-get install ack-grep

" }}}

" WHITESPACE {{{

Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespace characters

" }}}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" SIGNIFY {{{

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify' " ---indicate added, modified and removed lines (VCS)
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" }}}
Plug 'tomasiser/vim-code-dark'

" NERD Commenter {{{

Plug 'preservim/nerdcommenter' " -----------------Comment functions so powerfull

" }}}

call plug#end() "---------------------------------------- End of Vim-Plug define

