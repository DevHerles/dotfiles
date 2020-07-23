"  ________                ___ ___               .__
"  \______ \   _______  __/   |   \   ___________|  |   ____   ______
"   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
"   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
"  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
"          \/     \/            \/       \/                \/     \/
" | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

" GENERAL {{{

let mapleader = "\<Space>"
let maplocalleader = "\\"

" Use black hole for delete. Don't want to store in register with dd.
" For cut, use visual and x instead
nnoremap d "_d
vnoremap d "_d

" USEFUL {{{

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" }}}

" DISABLED {{{

" Disable Ctrl-Z
nnoremap <c-z> <NOP>

" Disable arrow keys (Vim don't need this)
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

" Disable ex mode
nnoremap Q <Nop>

" }}}

