" #  ________                ___ ___               .__
" #  \______ \   _______  __/   |   \   ___________|  |   ____   ______
" #   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
" #   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
" #  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
" #          \/     \/            \/       \/                \/     \/
" # | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

" DEFAULT-COLORSCHEME {{{

colorscheme tokyonight
let g:tokyonight_style = 'storm' " ------------------------------- night, storm

" }}}

" {{{ Generate random integer to choose color scheme

function! RandInt(Low, High) abort
python3 << EOF
import vim
import random
idx = random.randint(int(vim.eval('a:Low')), int(vim.eval('a:High')))
vim.command("let index = {}".format(idx))
EOF
return index
endfunction

function! RandInt2(Low, High) abort
python << EOF
import vim
import random
idx = random.randint(int(vim.eval('a:Low')), int(vim.eval('a:High')))
vim.command("let index = {}".format(idx))
EOF
return index
endfunction

" }}}

" {{{ Function called anytime the colorscheme is to be changed randomly

function! Init(Max) abort
  let s:p3 = 0
  if has('python3')
    let s:idx = RandInt(0, a:Max)
    let s:p3 = 1
  endif

  if has('python') && !s:p3
    let s:idx = RandInt2(0, a:Max)
  endif

  execute ":call SwitchColor(" . s:idx . ")"
endfunction

" }}}

let loaded_switchcolor = 1

let s:colorschemes = [ 'tokyonight-night', 'nord', 'tokyonight-storm', 'onedark' ]
let s:swback = 0    " background variants light/dark was not yet switched
let s:swindex = 0

function! SwitchColor(swinc)
  " if have switched background: dark/light
  if (s:swback == 1)
    let s:swback = 0
    let s:swindex += a:swinc
    let i = s:swindex % len(s:colorschemes)
    let s:colorscheme = split(s:colorschemes[i], "-")
    if (s:colorschemes[i] == 'tokyonight-night')
      execute "colorscheme " . s:colorscheme[0]
      let g:tokyonight_style = 'night' " ------------------- night, storm
      let g:tokyonight_enable_italic = 1
      let g:tokyonight_transparent_background = 0
      let g:airline_theme='tokyonight' " --------- Set status bar's theme
    elseif (s:colorschemes[i] == 'tokyonight-storm')
      execute "colorscheme " . s:colorscheme[0]
      let g:tokyonight_style = 'storm' " ------------------- night, storm
      let g:tokyonight_enable_italic = 1
      let g:tokyonight_transparent_background = 0
      let g:airline_theme='tokyonight' " --------- Set status bar's theme
    elseif (s:colorschemes[i] == 'nord')
      set termguicolors
      execute "colorscheme " . s:colorscheme[0]
      let g:airline_theme='nord' " --------------- Set status bar's theme
    elseif (s:colorschemes[i] == 'onedark')
      execute "colorscheme " . s:colorschemes[i]
      let g:airline_theme='onedark'
    else
      echo s:colorschemes[i]
      execute "colorscheme " . s:colorschemes[i]
    endif
  else
    let s:swback = 1
    if (&background == "light")
      execute "set background=dark"
    else
      execute "set background=light"
    endif
    " roll back if background is not supported
    if (!exists('g:colors_name'))
      return SwitchColor(a:swinc)
    endif
  endif

  " show current name on screen. :h :echo-redraw
  redraw
  execute "colorscheme"
endfunction

" {{{ change color randomly on command

function! ChangeColour() abort
  let g:indicies = Init(len(s:colorschemes))
endfunction

" }}}

" MAPPINGS {{{

map <F8> :call ChangeColour()<CR>
map <F9> :colorscheme aranda<CR>

" }}}
"
" autocmd VimEnter * execute ChangeColour()
