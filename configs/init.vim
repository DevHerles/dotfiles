"  ________                ___ ___               .__
"  \______ \   _______  __/   |   \   ___________|  |   ____   ______
"   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
"   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
"  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
"          \/     \/            \/       \/                \/     \/
" | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

call plug#begin('~/.config/nvim/plugged') " --------------------- Start vim plug

Plug 'skbolton/embark'
Plug 'google/yapf'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'voldikss/vim-floaterm'

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" }}}

" VIM-MUNDO {{{

Plug 'simnalamburt/vim-mundo'

" }}}

" DART, FLUTTER {{{

Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'thosakwe/vim-flutter'

" }}}

" VIM EXPAND REGION {{{

Plug 'terryma/vim-expand-region' " Press + to expand the visual selection and _ to shrink it.

" }}}

" COLORS, THEMES {{{

Plug 'DevHerles/aranda', { 'rtp': 'vim' }

" }}}

" TOOLBAR {{{

Plug 'bling/vim-airline' " --------------------------------- Status bar, Tabline
Plug 'vim-airline/vim-airline-themes' "  Vim-Airline Themes (To use tabline ext)
Plug 'tpope/vim-fugitive' " --------- Just use to show git status in Vim-Airline

" }}}

" FINDER {{{

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " ------------------------------------------- fzf in vim

" }}}

" RANGER {{{

Plug 'francoiscabrol/ranger.vim' " ---------Ranger integration in vim and neovim

" }}}

" NAVIGATE {{{

Plug 'easymotion/vim-easymotion' " ---------- Jump around the screen like a boss

" }}}

" FASTER CODE {{{

Plug 'tmsvg/pear-tree' " ------------------------------------ Auto pair brackets
"Plug 'alvan/vim-closetag' " -------------------------------- Auto close html tag
Plug 'tpope/vim-surround' " -------------------------------------- Auto surround
Plug 'tpope/vim-repeat' " ----------------------------- dot repeat with pluggins
Plug 'Yggdroot/indentLine' " --------------------------- Indent code with v-line
Plug 'mg979/vim-visual-multi' " -------------------------------- Multiple Cursor

" }}}

" UTILS {{{

Plug 'NLKNguyen/copy-cut-paste.vim' " --------------- Copy, Paste with Clipboard
"Plug 'segeljakt/vim-silicon' " ---------------------------- Coud be enteresting
Plug 'RRethy/vim-illuminate' " -- Auto highlight other uses of word under cursor
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

" SIGNIFY {{{

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify' " ---indicate added, modified and removed lines (VCS)
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" }}}

" NERD Commenter {{{

Plug 'preservim/nerdcommenter' " -----------------Comment functions so powerfull

" }}}

call plug#end() " --------------------------------------- End of Vim-Plug define

