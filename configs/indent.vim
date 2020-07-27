"  ________                ___ ___               .__
"  \______ \   _______  __/   |   \   ___________|  |   ____   ______
"   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
"   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
"  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
"          \/     \/            \/       \/                \/     \/
" | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

" INDENT {{{

"let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
let g:indentLine_char = '▏'

augroup languages_indent
    autocmd!
    autocmd FileType vim    setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType xml    setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType json   setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
augroup END

" }}}
