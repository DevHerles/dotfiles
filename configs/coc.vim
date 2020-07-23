"  ________                ___ ___               .__
"  \______ \   _______  __/   |   \   ___________|  |   ____   ______
"   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
"   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
"  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
"          \/     \/            \/       \/                \/     \/
" | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

" EXTENSIONS {{{

" Install coc extensions
if match(&rtp, 'coc.nvim') >= 0
    let s:languages = [
        \ 'coc-xml',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-tsserver',
        \ 'coc-docker',
        \ 'coc-gocode',
        \ 'coc-json',
        \ 'coc-python',
        \ 'coc-rls',
        \ 'coc-vimtex',
        \ 'coc-vimlsp',
        \ 'coc-svg',
        \ 'coc-sh',
        \ ]

    let s:frameworks = [
        \ 'coc-angular',
        \ 'coc-vimlsp',
        \ ]

    let s:linters = [
        \ 'coc-tslint',
        \ 'coc-eslint',
        \ 'coc-stylelint',
        \ 'coc-diagnostic',
        \ ]

    let s:utils = [
        \ 'coc-syntax',
        \ 'coc-dictionary',
        \ 'coc-lists',
        \ 'coc-tag',
        \ 'coc-emoji',
        \ 'coc-github',
        \ 'coc-snippets',
        \ 'coc-calc',
        \ 'coc-emmet',
        \ 'coc-prettier',
        \ 'coc-yank'
        \ ]

    let s:extensions = s:languages + s:frameworks + s:linters + s:utils

    let g:coc_global_extensions = s:extensions

    if exists('g:did_coc_loaded')
        call coc#add_extension()
    end
endif

" }}}

" MAPPINGS {{{

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gl :CocList <CR>
nmap <silent> go :CocList outline<CR>
nmap <silent> gL :CocListResume <CR>

nmap <silent><leader>xa <Plug>(coc-codelens-action)
vmap <silent><leader>a  <Plug>(coc-codeaction-selected)
nmap <silent><leader><leader>.  <Plug>(coc-codeaction)
nmap <silent><leader><leader>e :CocCommand flutter.emulators<CR>
nmap <silent><leader><leader>r :CocCommand flutter.run<CR>

nmap <silent> gR <Plug>(coc-rename)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> ge <Plug>(coc-refactor)
" the <CR> should not be necessary but i get some unwanted output
nmap <silent> ga <Plug>(coc-codeaction-selected)<CR>
vmap <silent> ga <Plug>(coc-codeaction-selected)<CR>
nmap <silent> gA :CocAction <CR>
nmap <silent> gf <Plug>(coc-fix-current)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" }}}

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
" TODO add these to which key
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Explorer
let g:coc_explorer_global_presets = {
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 40,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'right-center',
\      'floating-width': 40,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }
"nmap <silent> <space>e :CocCommand explorer<CR>
nnoremap <silent> <leader>e :CocCommand explorer<CR>
nmap <space>l :CocCommand explorer --preset floatingRightside<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" Snippets
" Use <C-l> for trigger snippet expand.
"imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
"vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
"let g:coc_snippet_next = '<leader-`>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
"let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <S-o> <Plug>(coc-snippets-expand-jump)

" HIGHLIGHT {{{

hi CocErrorSign  ctermfg=Red guifg=#ef8189
hi CocWarningSign  ctermfg=Brown guifg=#e8b586
hi CocInfoSign  ctermfg=Yellow guifg=#61afef
hi CocHintSign  ctermfg=Blue guifg=#56b6c2

" }}}

" EXTENSIONS SETTINGS {{{

" coc-yank
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" }}}
