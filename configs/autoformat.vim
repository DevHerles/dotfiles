"  ________                ___ ___               .__
"  \______ \   _______  __/   |   \   ___________|  |   ____   ______
"   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
"   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
"  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
"          \/     \/            \/       \/                \/     \/
" | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

" CODEFoRMAT {{{

augroup autoformat_settings
    autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    autocmd FileType python AutoFormatBuffer yapf
    autocmd FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"
    " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

" }}}
