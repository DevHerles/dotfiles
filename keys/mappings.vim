"  ________                ___ ___               .__
"  \______ \   _______  __/   |   \   ___________|  |   ____   ______
"   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
"   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
"  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
"          \/     \/            \/       \/                \/     \/
" | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" <TAB>: completion.
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" WINDOW {{{

nnoremap n nzz
nnoremap N Nzz

" --------------------------------------------Switch between the last two files
nnoremap <tab><tab> <c-^>
nnoremap <silent><Leader>r :e!<CR>

" -------------------------------------------------------------Act like D and C
nnoremap Y y$

"nnoremap <silent> <Leader>= gg=G

" ----------------------------------------------------Delete the current buffer
nnoremap <silent> <Leader>q :bdelete<CR>

" ------------------------------------Deletes all except with unwritten changes
nnoremap <silent><Leader>Q :bufdo! bd<CR>
nnoremap <silent><Leader>+ :vertical resize +20<CR>
nnoremap <silent> <Leader>- :vertical resize -20<CR>
noremap <silent> <Leader>h :<C-u>split<CR>
noremap <silent> <Leader>v :<C-u>vsplit<CR>
noremap <C-j> <C-w>j
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <silent> <Leader>w :wa<CR>
nnoremap <silent> L :call MyNext()<CR>
nnoremap <silent> H :call MyPrev()<CR>

" ------When I forgot to start vim using sudo
"cnoremap <C-s>w execute 'silent! write !SUDO_ASKPASS=`which ssh-askpass` sudo tee % >/dev/null' <bar> edit!

" -------------------------------------------------------Resizing split windows
"nnoremap ,w :call SwapSplitResizeShortcuts()<CR>
" -------------------------------------------------------Escape for insert mode
imap jk <Esc>

" ----------------------------------------------------Firs char in current line
map 0 ^

" -------------------------------------------------------duplicate current line
noremap <Leader>d yyp

" ---------------------------------------------------------Move lines (UP/DoWN)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" ------------------------ Jump back to your last edit (do this in normal mode)
nnoremap <Leader>p g;

" -------------------------Jump back to your last edit (do this in normal mode)
nnoremap <Leader>n g,

"nnoremap <Leader>o ^o " -Jump back to the position you were last (Out),jump back
"nnoremap <Leader>i ^i " ---Jump back to the position you were last (In), forward

" -------------------------------------------------------Clear search highlight
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" -------------------------Vmap for maintain Visual Mode after shifting > and <
vmap < <gv

" -------------------------Vmap for maintain Visual Mode after shifting > and <
vmap > >gv

" ------------------------------------------Change to current working directory
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" ----------------------------------------------------------------Open init.vim
map ,v :e $MYVIMRC<CR>

" ----------------------MyNext() and MyPrev(): Movement between tabs OR buffers
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

" ---------------------------SwapSplitResizeShortcuts(): Resizing split windows
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

highlight BadWhitespace ctermbg=red guibg=default

" }}}

" ACK {{{

let g:ackpreview = 0
let g:ack_autofold_results = 0
let g:ackhighlight = 1

cnoreabbrev Ack Ack!
cnoreabbrev ack Ack!
nnoremap <Leader>a :Ack!<Space><C-R><C-W>

" }}}

" RIPGREP {{{

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

" }}}

" DELETE TRAILING {{{

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge " /\s\+$/ regex for one or more whitespace characters followed by the end of a line
  exe "normal `z"
endfunc

autocmd BufWrite *.* :call DeleteTrailingWS()

" }}}
