"  ________                ___ ___               .__
"  \______ \   _______  __/   |   \   ___________|  |   ____   ______
"   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
"   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
"  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
"          \/     \/            \/       \/                \/     \/
" | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

" WHICH-KEY {{{

set notimeout
set timeoutlen=100

let mapleader=","

" ------------------------------------------------------ Register which key map
autocmd! User vim-which-key call which_key#register(',', 'g:which_key_map')

" ----------------------------------------------------- Map leader to which_key
nnoremap <silent> <leader><leader> :WhichKey ','<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual ','<CR>

let g:which_key_map =  {} " ------------------------- Create map to add keys to
let g:which_key_sep = '→' " -------------------------------- Define a separator

let g:which_key_use_floating_win = 0 " - Not a fan of floating windows for this

" ----------------------------------------------- Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" ------------------------------------------------------------ Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" ------------------------------------------------------------- Single mappings
let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle'  , 'comment' ]
let g:which_key_map['e'] = [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map['f'] = [ ':FZF'                       , 'search files' ]
let g:which_key_map['h'] = [ '<C-W>s'                     , 'split below']
let g:which_key_map['r'] = [ ':Ranger'                    , 'ranger' ]
let g:which_key_map['S'] = [ ':Startify'                  , 'start screen' ]
let g:which_key_map['T'] = [ ':Rg'                        , 'search text' ]
let g:which_key_map['v'] = [ '<C-W>v'                     , 'split right']
let g:which_key_map['z'] = [ 'Goyo'                       , 'zen' ]

" ------------------------------------------------------------- t is for search
let g:which_key_map.t = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }

" --------------------------------------------------------------- m is for dart
let g:which_key_map.m = {
      \ 'name' : '+dart' ,
      \ 'd' : ['<Plug>(coc-definition)'              , 'coc-definition'],
      \ 'y' : ['<Plug>(coc-type-definition)'         , 'coc-type-definition'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'coc-implementation'],
      \ 'r' : ['<Plug>(coc-references)'              , 'coc-references'],
      \ 'R' : ['<Plug>(coc-rename)'                  , 'coc-rename'],
      \ 'f' : ['<Plug>(coc-fix-current)'             , 'coc-fix-current'],
      \ 'F' : ['<Plug>(coc-refactor)'                , 'coc-refactor'],
      \ 'x' : ['<Plug>(coc-codelens-action)'         , 'coc-codelens-action'],
      \ '.' : ['<Plug>(coc-codeaction)'              , 'coc-codeaction'],
      \ 'a' : ['<Plug>(coc-codeaction-selected)'     , 'coc-codeaction-selected'],
      \ 'A' : [':CocAction <CR>'                     , 'coc-action'],
      \ 'E' : [':CocCommand flutter.emulators <CR>'  , 'flutter-emulators'],
      \ 'e' : [':CocCommand flutter.run <CR>'        , 'flutter-run'],
      \ 'l' : [':CocList'                            , 'coc-list'],
      \ 'o' : [':CocList outline'                    , 'coc-list outline'],
      \ 'L' : [':CocListResume'                      , 'coc-list resume'],
      \ }

" }}}
