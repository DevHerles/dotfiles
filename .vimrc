syntax enable
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformat=unix
set bomb
set binary
set hidden
set mouse=a 			" Enable mouse (for window resizing)
set backspace=indent,eol,start	" Fix backspace indent
set hlsearch 			" Searching
set incsearch 			" Search as you type
set ignorecase
set smartcase
set showcmd 			" Show (partial) command in status line.
set autoindent
set splitbelow 			" More natural split open
set splitright 			" More natural split open
set noequalalways
set ruler
set number 			" Show current line number
set relativenumber 		" Show relative line numbers
set cursorline 			" Highlight current line
set cursorcolumn		" Highlight current column
set showmatch 			" Show matching part of bracket pairs [] () {}
set background=dark
set gcr=a:blinkon0 		" Disable the blinking cursor.
set scrolloff=3
set laststatus=2 		" Status bar
set switchbuf=usetab
set list 			" Display unprintable chars
set listchars=tab:→\ ,extends:❯,precedes:❮,nbsp:␣,eol:¬,trail:⋅
set showbreak=↪
set nowrap
set autoread
set termguicolors
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set nobackup
set nowritebackup
set noswapfile
set wildmenu			" Display command line's tab complete options as menu.
set spelllang=es,en		" Set the spelling language to Spanish and English
set spell			" Enable spell checking.
set confirm			" Display a confirmation dialog when closing an unsaved file.
set scrolloff=3			" The number of screen lines to keep above and below the cursor.
set sidescrolloff=5		" The number of screen columns to keep to the left and right of the cursor.
set noerrorbells		" Disable beep on errors.
set visualbell			" Flash de screen instead of beeping on errors.
set showmode			" Show current mode at the bottom.
set ruler			" Always show cursor position.
"set completeopt+=noinsert	" If you use the noinsert flag in completeopt in combination with menu, the first item will be selected (but not inserted into the buffer).
set statusline=%!MyStatusLine()
set undofile
set nofoldenable

" make the highlighting of tabs and other non-text less annoying
highlight SpecialKey ctermfg=19 guifg=#333333
highlight NonText ctermfg=19 guifg=#333333

if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))


"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons' | Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'blueyed/vim-diminactive' " This is a plugin for Vim to dim inactive windows.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim' " Don't forget: sudo apt-get install ack-grep
Plug 'tpope/vim-surround' " cs'<q> changes 'Hello World' to <q>Hello World</q>. ds<q> will remove the tags
Plug 'Yggdroot/indentLine' " Adds lines showing indentation
Plug 'ap/vim-buftabline' " Forget Vim tabs – now you can have buffer tabs
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " Semshi provides semantic highlighting for Python in Neovim.
Plug 'tpope/vim-fugitive' | Plug 'junegunn/gv.vim' | Plug 'airblade/vim-gitgutter' " It shows which lines have been added(+), modified(~), or removed(-).
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'terryma/vim-multiple-cursors' " <C-n> highlights a word and then <C-n> again highlights the next one. c to change text. <C-p> to go back. <C-x> to remove current highlight
Plug 'terryma/vim-expand-region' " Press + to expand the visual selection and _ to shrink it.
Plug 'osyo-manga/vim-over' " :substitute preview
Plug 'pangloss/vim-javascript' | Plug 'mxw/vim-jsx'
Plug 'simnalamburt/vim-mundo'
Plug 'tweekmonster/braceless.vim'
Plug 'easymotion/vim-easymotion'
Plug 'alvan/vim-closetag'
Plug 'christoomey/vim-tmux-navigator'
Plug 'moll/vim-bbye'
Plug 'justinmk/vim-sneak'
Plug 'vimwiki/vimwiki'
"Plug 'chrisbra/csv.vim'
"Plug 'tmhedberg/SimpylFold'
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'junegunn/limelight.vim'
Plug 'kalekundert/vim-coiled-snake' | Plug 'Konfekt/FastFold'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
"Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets'
"" Colorscheme
Plug 'ap/vim-css-color' " A very fast, multi-syntax context-sensitive color name highlighter
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'tomasiser/vim-code-dark'
Plug 'dracula/vim'

Plug 'vim-airline/vim-airline'
" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'mlaursen/vim-react-snippets'
"Plug 'Shougo/deoppet.nvim', { 'do': ':UpdateRemotePlugins' }

" Initialize plugin system
call plug#end()

" Required:
filetype plugin indent on

"" Map leader to Space
let mapleader="\<Space>"

"*****************************************************************************
" Custom configs
" NERDTree
"*****************************************************************************
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$', 'node_modules']     " Ignore files in NERDTree
let NERDTreeWinSize=40

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

" NERDTree's File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * call StartUp()
nnoremap <silent><Leader>t :NERDTreeToggle<CR>

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
"call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
"call NERDTreeHighlightFile('py', 'cyan', 'none', '#ff00ff', '#151515')
"call NERDTreeHighlightFile('xml', 'yellow', 'none', 'yellow', '#151515')
"
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"*****************************************************************************
" Mundo files
"*****************************************************************************
if has('nvim')
    set undodir=~/.vim/undo
endif
augroup vimrc
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END
if !exists('g:not_finish_vimplug')
  if has('nvim')
      " https://github.com/neovim/neovim/wiki/FAQ
      set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
  endif
endif
colorscheme gruvbox

"*****************************************************************************
" Deoplete
"*****************************************************************************
"highlight Pmenu ctermbg=8 guibg=#606060
"highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
"highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

if !exists('g:deoplete#sources')
    let g:deoplete#sources = {}
endif
if !exists('g:deoplete#keyword_patterns')
    let g:deoplete#keyword_patterns = {}
endif
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 2
let g:deoplete#manual_completion_start_length = 0
let g:deoplete#keyword_patterns['default'] = '\h\w*'
let g:deoplete#omni#input_patterns.python = '([^. \t]\.|^\s*@|^\s*from\s.+ import |^\s*from |^\s*import )\w*'
let g:deoplete#sources.python = ['ultisnips','jedi']
let g:deoplete#sources#jedi#show_docstring = 0
"inoremap <expr><TAB> pumvisible() ? "\<C-y>" : "\<TAB>"

" Auto complete with C-Space
inoremap <silent><expr> <C-Space>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<C-Space>" :
        \ deoplete#manual_complete()

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
"}}}

" Auto close preview when done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Set allowed sources
call deoplete#custom#source('ultisnips', 'rank', 1000)
"call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

"Q: Deoplete does not work with vim-multiple-cursors.
"A: You must disable deoplete when using vim-multiple-cursors. >
function! g:Multiple_cursors_before()
    call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function! g:Multiple_cursors_after()
    call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction

"*****************************************************************************
" vim-closetag
"*****************************************************************************
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.js'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = "<leader>>"

"*****************************************************************************
" fugitive
"*****************************************************************************
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>12 :diffget<CR>
nnoremap <leader>21 :diffput<CR>

"*****************************************************************************
" braceless
"*****************************************************************************
autocmd FileType python BracelessEnable +indent

"*****************************************************************************
" startify
"*****************************************************************************
let g:startify_custom_header = ['']
let g:startify_list_order = [
      \ ['        Most recently used files'],
      \ 'files',
      \ ['        Most recently used in current directory'],
      \ 'dir',
      \ ['        Sessions'],
      \ 'sessions',
      \ [        'Bookmarks'],
      \ 'bookmarks',
      \ ['        Commands'],
      \ 'commands',
      \ ]
" don't change vim's dir when I select a file
let g:startify_change_to_dir = 0
nnoremap <silent> <Leader><Tab> :Startify<CR>

"*****************************************************************************
" signify
"*****************************************************************************
let g:signify_vcs_list = [ 'git' ]
let g:signify_realtime = 1
let g:signify_sign_show_count = 0
let g:signify_sign_change = '-'

"*****************************************************************************
" ale: signs for errors and warnings
"*****************************************************************************
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

"*****************************************************************************
" vim.buftabline
"*****************************************************************************
noremap <C-left> :bprev<CR>
noremap <C-right> :bnext<CR>

"*****************************************************************************
"*****************************************************************************
" sneak
let g:sneak#label = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

"*****************************************************************************
" fzf
"*****************************************************************************
nnoremap <silent> <C-p> :Files <CR>
"nnoremap <silent> <Leader>f :Find <CR>
"nnoremap <silent> <Leader><Tab> :Buffers <CR>
"*****************************************************************************
" jedi-vim
"*****************************************************************************
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
"let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 1
let g:jedi#popup_select_first = 1
let g:jedi#show_call_signatures = "1"
let g:jedi#smart_auto_mappings = 1

"*****************************************************************************
" UltiSnips
"*****************************************************************************
set rtp+=~/.dotfiles
let g:UltiSnipsSnippetsDir = "~/.dotfiles/my_snippets"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'my_snippets']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Revisar https://pastebin.com/015JP2Yc

"*****************************************************************************
" Indentline
"*****************************************************************************
"let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
let g:indentLine_char = '▏'

"*****************************************************************************
" Semshi
"*****************************************************************************
let g:deoplete#auto_complete_delay = 100 " Completion triggers may block Semshi from highlighting instantly.
let g:semshi#active = 1

"*****************************************************************************
" vim-over
"*****************************************************************************
map <Leader>s :OverCommandLine<CR>

"*****************************************************************************
" Window
"*****************************************************************************
nnoremap n nzz
nnoremap N Nzz
" Switch between the last two files
nnoremap <tab><tab> <c-^>

" command typo mapping
cnoremap WQ wq
cnoremap Wq wq
cnoremap QA qa
cnoremap qA qa
cnoremap Q! q!

" replace word under cursor, globally, with confirmation
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap <Leader>r y :%s/<C-r>"//gc<Left><Left><Left>

" re-indent file and jump back to where the cursor was
map <F7> mzgg=G`z

" prevent entering ex mode accidentally
nnoremap Q <Nop>

" fold file based on indent
nnoremap <silent> <leader>zi :setlocal foldmethod=indent<CR>

nnoremap <silent> <F9> :windo diffthis<CR>
" rename current file
nnoremap <Leader>rn :!mv <C-R>=expand("%")<CR>

" Fast saving
"nmap <Leader>w :w!<cr>

" Center the screen
nnoremap <Leader><Leader> zz

" Act like D and C
nnoremap Y y$

" Copy/Paste from register
vnoremap <leader>cc "*y
map <leader>vv "*p

nnoremap <silent> <Leader>= gg=G
"command W :execute ':silent w sudo tee % > /dev/null' | :edit!
noremap <silent> <leader>u <ESC>?=<CR>/(<CR>au<ESC>

nnoremap <silent> <Leader>q :Bdelete<CR>
nnoremap <silent> <Leader>+ :vertical resize +20<CR>
nnoremap <silent> <Leader>- :vertical resize -20<CR>
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
noremap <C-j> <C-w>j
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-s> :w<CR>
noremap <C-u> :e ++ff=dos<CR>
nnoremap <silent> L :call MyNext()<CR>
nnoremap <silent> H :call MyPrev()<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Resizing split windows
nnoremap ,w :call SwapSplitResizeShortcuts()<CR>
imap jk <Esc>
map 0 ^
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/ " it will mark +80 characters as error
let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(81,999),",")
" Search in line
noremap <Leader>( ?(<CR>a

" duplicate current line
noremap <Leader>d yyp

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Jump back to your last edit (do this in normal mode).
nnoremap <Leader>p g;
nnoremap <Leader>n g,

" Jump back to the position you were last
"nnoremap <Leader>o ^o	" (Out) will jump back
"nnoremap <Leader>i ^i	" (In) will go back forward

"" Clear search highlight
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Exit from Terminal mode in Neovim
tnoremap <Esc> <C-\><C-n>

" change working directory to where the file in the buffer is located
" if user types `,cd`
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

map <Leader>v :e $MYVIMRC<CR>

" MyNext() and MyPrev(): Movement between tabs OR buffers
function! MyNext()
    if exists( '*tabpagenr' ) && tabpagenr('$') != 1
        " Tab support && tabs open
        normal gt
    else
        " No tab support, or no tabs open
        execute ":bnext"
    endif
endfunction
function! MyPrev()
    if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
        " Tab support && tabs open
        normal gT
    else
        " No tab support, or no tabs open
        execute ":bprev"
    endif
endfunction

" SwapSplitResizeShortcuts(): Resizing split windows
if !exists( 'g:resizeshortcuts' )
    let g:resizeshortcuts = 'horizontal'
    nnoremap _ <C-w>-
    nnoremap + <C-w>+
endif

function! SwapSplitResizeShortcuts()
    if g:resizeshortcuts == 'horizontal'
        let g:resizeshortcuts = 'vertical'
        nnoremap _ <C-w><
        nnoremap + <C-w>>
        echo "Vertical split-resizing shortcut mode."
    else
        let g:resizeshortcuts = 'horizontal'
        nnoremap _ <C-w>-
        nnoremap + <C-w>+
        echo "Horizontal split-resizing shortcut mode."
    endif
endfunction

"*****************************************************************************
" easymotion
"*****************************************************************************
map  <Leader>s <Plug>(easymotion-bd-f2)
nmap <Leader>s <Plug>(easymotion-overwin-f2)

map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"*****************************************************************************
" Git commit browser
"*****************************************************************************
nnoremap <silent> <Leader>gc :GV<CR>

"*****************************************************************************
" vim-javascript
"*****************************************************************************
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"

let g:jsx_ext_required = 1
let g:jsx_pragma_required = 1

set conceallevel=1

map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

"*****************************************************************************
" Ack
"*****************************************************************************
let g:ackpreview = 0
let g:ack_autofold_results = 0
let g:ackhighlight = 1

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space><C-R><C-W>
nnoremap <Leader>ff 0yi":Ack!<Space>'<C-R>" = fields' --py<CR> " Where the field was defined
nnoremap <Leader>fm 0yi":Ack!<Space>"def <C-R>"" --py<CR> "Where de method was defined
nnoremap <Leader>mn yit:Ack!<Space>"_name = '<C-R>"'" --py<CR> "Where de module was defined
vnoremap <Leader>mn y:Ack!<Space>"_name = '<C-R>"'" --py<CR> "Where de module was defined
vnoremap <Leader>ai y:Ack!<Space>"_inherit = '<C-R>"'" --py<CR> "Where de module was inherited
nnoremap <Leader>mi yit:Ack!<Space>"_inherit = '<C-R>"'" --py<CR> "Where de module was inherited
nnoremap <Leader>ap :Ack!<Space><C-R><C-W> --py<CR> "In all Python files
nnoremap <Leader>ax :Ack!<Space><C-R><C-W> --xml<CR> "In all XML files

" ripgrep
if executable('rg')
  "" Set default grep to ripgrep
  set grepprg=rg\ --vimgrep

  "" Set default ripgrep configs for fzf
  "# --files: List files that would be searched but do not search
  "# --no-ignore: Do not respect .gitignore, etc...
  "# --hidden: Search hidden files and folders
  "# --follow: Follow symlinks
  "# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
  let $FZF_DEFAULT_COMMAND ='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

  "" Define custom :Find command to leverage rg
  " --column: Show column number
  " --line-number: Show line number
  " --no-heading: Do not show file headings in results
  " --fixed-strings: Search term as a literal string
  " --ignore-case: Case insensitive search
  " --no-ignore: Do not respect .gitignore, etc...
  " --hidden: Search hidden files and folders
  " --follow: Follow symlinks
  " --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
  " --color: Search color options
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
endif

"*****************************************************************************
" Expand region
"*****************************************************************************
" Extend the global default (NOTE: Remove comments in dictionary before sourcing)
let g:expand_region_text_objects = {
      \ 'iw'  :1,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :1,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open templates when editing a new file
au bufNewFile *.xml 0r ~/.dotfiles/templates/template.xml

"*****************************************************************************
" File types
"*****************************************************************************
highlight BadWhitespace ctermbg=red guibg=default

" SNIPPETS
au BufRead,BufNewFile *.snippet set expandtab
au BufRead,BufNewFile *.snippet set tabstop=4
au BufRead,BufNewFile *.snippet set softtabstop=4
au BufRead,BufNewFile *.snippet set shiftwidth=4
au BufRead,BufNewFile *.snippet set autoindent
au BufRead,BufNewFile *.snippet match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.snippet match BadWhitespace /\s\+$/
au         BufNewFile *.snippet set fileformat=unix
au BufRead,BufNewFile *.snippet let b:comment_leader = '<!--'

" XML
au BufRead,BufNewFile *.xml set expandtab
au BufRead,BufNewFile *.xml set tabstop=4
au BufRead,BufNewFile *.xml set softtabstop=4
au BufRead,BufNewFile *.xml set shiftwidth=4
au BufRead,BufNewFile *.xml set autoindent
au BufRead,BufNewFile *.xml match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.xml match BadWhitespace /\s\+$/
au         BufNewFile *.xml set fileformat=unix
au BufRead,BufNewFile *.xml let b:comment_leader = '<!--'
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" HTML
au BufRead,BufNewFile *.html set filetype=xml
au BufRead,BufNewFile *.html set expandtab
au BufRead,BufNewFile *.html set tabstop=4
au BufRead,BufNewFile *.html set softtabstop=4
au BufRead,BufNewFile *.html set shiftwidth=4
au BufRead,BufNewFile *.html set autoindent
au BufRead,BufNewFile *.html match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.html match BadWhitespace /\s\+$/
au         BufNewFile *.html set fileformat=unix
au BufRead,BufNewFile *.html let b:comment_leader = '<!--'

" JS
au BufRead,BufNewFile *.js set expandtab
au BufRead,BufNewFile *.js set tabstop=2
au BufRead,BufNewFile *.js set softtabstop=2
au BufRead,BufNewFile *.js set shiftwidth=2
au BufRead,BufNewFile *.js set autoindent

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge " /\s\+$/ regex for one or more whitespace characters followed by the end of a line
  exe "normal `z"
endfunc

au BufWrite           *.* :call DeleteTrailingWS()

function! MyStatusLine()
    let statusline = ""
    " Filename (F -> full, f -> relative)
    let statusline .= "%f"
    " Buffer flags
    let statusline .= "%( %h%1*%m%*%r%w%) "
    " File format and type
    let statusline .= "(%{&ff}%(\/%Y%))"
    " Left/right separator
    let statusline .= "%="
    " Line & column
    let statusline .= "(%l,%c%V) "
    " Character under cursor (decimal)
    let statusline .= "%03.3b "
    " Character under cursor (hexadecimal)
    let statusline .= "0x%02.2B "
    " File progress
    let statusline .= "| %P/%L"
    return statusline
endfunction

nnoremap <Leader>y :call<SID>EightyLine()<cr>
fun! s:EightyLine()
 if !exists('w:eightyline')
  let w:eightyline = 1
  :set colorcolumn=80  " highlight three columns after 'textwidth'
  :highlight ColorColumn ctermbg=16 guibg=#000000
 else
  unl w:eightyline
  :set colorcolumn=80  " highlight three columns after 'textwidth'
  :highlight ColorColumn NONE
 endif
endfunction

" Cursor to yellow on insert mode
" Blue on command/other mode
" Note the use of hex codes (ie 3971ED)
if exists('$TMUX')
    let &t_EI = "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\"
    let &t_SI = "\<Esc>Ptmux;\<Esc>\033]PlFBA922\033\\"
    silent !echo -ne "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\"
    autocmd VimLeave * silent !echo -ne "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\"
else
    let &t_EI = "\033]Pl3971ED\033\\"
    let &t_SI = "\033]PlFBA922\033\\"
    silent !echo -ne "\033]Pl3971ED\033\\"
    autocmd VimLeave * silent !echo -ne "\033]Pl3971ED\033\\"
endif
