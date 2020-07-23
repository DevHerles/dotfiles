"  ________                ___ ___               .__
"  \______ \   _______  __/   |   \   ___________|  |   ____   ______
"   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
"   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
"  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
"          \/     \/            \/       \/                \/     \/
" | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

" COLORS SOLARIZED {{{

let g:onedark_termcolors=256
:silent! colorscheme aranda " -------------------------------- Set onedark theme
:hi Normal guibg=NONE ctermbg=NONE " -------------- Transparent background color

" }}}

" AIRLINE {{{

let g:airline_theme='aranda' " -------------------------- Set status bar's theme
let g:airline_powerline_fonts = 1 " ---------- Just work with patched NERD fonts
let g:airline_section_c = '%t' "--filename " " ----------- Only show file's name
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' "  Hide format type
let g:airline#extensions#tabline#enabled = 1 " ------------------ Enable tabline
let g:airline#extensions#tabline#fnamemod = ':t' " -- Just show file name in tab
let g:airline#extensions#tabline#enabled=1 " -------- Buffers at the top as tabs
let g:airline#extensions#tabline#show_tab_type=1 " --------- Don't show tab type

" }}}

" AIRLINE SYMBOLS {{{

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.linenr = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.readonly = ''

let g:airline#extensions#quickfix#quickfix_text = 'QF'
let g:airline#extensions#quickfix#location_text = 'LL'

" Disable unused extensions (Improve Performance)
let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#capslock#enabled   = 0
let g:airline#extensions#csv#enabled        = 0
let g:airline#extensions#ctrlspace#enabled  = 0
let g:airline#extensions#eclim#enabled      = 1
let g:airline#extensions#hunks#enabled      = 0
let g:airline#extensions#nrrwrgn#enabled    = 0
let g:airline#extensions#promptline#enabled = 0
let g:airline#extensions#syntastic#enabled  = 0
let g:airline#extensions#taboo#enabled      = 0
let g:airline#extensions#tagbar#enabled     = 0
let g:airline#extensions#virtualenv#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

set noshowmode " ---------------- Don't show mode (Normal, Insert...) in airline

" }}}

" FZF.VIM {{{

" Custom ag command to ignore files in node_modules, .git and include hidden files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': 'ag --hidden --ignore .git -g ""'}, <bang>0)

" Just ignore .git folders
command! -bang -nargs=? -complete=dir DefaultFiles
  \ call fzf#vim#files(<q-args>, {'source': 'ag --hidden --skip-vcs-ignores --ignore .git -g ""'}, <bang>0)

" Mappings
nmap <leader>f        :FZF<cr>
nmap <leader>c        :Commits<cr>

" Remapping alt-a, alt-d to ctrl-a, ctrl-d to use on oxs
autocmd VimEnter *
\ command! -bang -nargs=* Ag
\ call fzf#vim#ag(<q-args>, '', { 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all' }, <bang>0)

" Use o to open candidate in quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> o <CR>

" Action mappings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': '-tabnew' }

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

" Hide statusline when open fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" }}}

" INDENT LINE {{{

let g:indentLine_char = '┆'

augroup indentLine_config
    autocmd!
    autocmd InsertEnter *.json setlocal concealcursor=
    autocmd InsertLeave *.json setlocal concealcursor=inc
augroup END

" }}}

" EASY MOTION {{{

let g:EasyMotion_do_mapping = 0 " --------------------- Disable default mappings
let g:EasyMotion_smartcase = 1 " -------------- Turn on case insensitive feature

" Mappings
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>s <Plug>(easymotion-overwin-f)
map <Leader>S <Plug>(easymotion-overwin-f2)

" Powerful mapping, just type s, S, J, K is enough :))
nmap s <Plug>(easymotion-overwin-f)
nmap S <Plug>(easymotion-overwin-f2)

" }}}

" TREE PAIRS {{{

let g:pear_tree_pairs = {
  \ '(':    {'closer': ')'},
  \ '[':    {'closer': ']'},
  \ '{':    {'closer': '}'},
  \ "'":    {'closer': "'"},
  \ '"':    {'closer': '"'},
  \ '/*':   {'closer': '*/'},
  \ '<!--': {'closer': '-->'}
  \ }

let g:pear_tree_repeatable_expand = 0

" }}}

" PRETTIER {{{

let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'false'

" }}}

" VIM-ILLUMINATE {{{

hi link illuminatedWord Visual

" }}}
