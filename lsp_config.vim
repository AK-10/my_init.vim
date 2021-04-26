
" vim-lsp config
" let g:lsp_diagnostics_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
" let g:asyncomplete_auto_popup = 1
" let g:asyncomplete_popup_delay = 200
" let g:lsp_text_edit_enabled = 1
" " vim-lsp:debug
" " let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/.config/nvim/log/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/.config/nvim/log/asyncomplete.log')
"
" if executable('solargraph')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'solargraph',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
"         \ 'initialization_options': {"diagnostics": "true"},
"         \ 'whitelist': ['ruby'],
"         \ })
" endif
"
" function! s:on_lsp_buffer_enabled() abort
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
" 	nmap <silent> gd :split \| :LspDefinition <CR>
" 	nmap <silent> gt :split \| :LspTypeDefintion <CR>
" 	nmap <silent> gi :split \| :LspImplementation <CR>
" 	nmap <silent> gr :split \| :LspReferences <CR>
"
" 	" nmap <silent> <buffer> gd :split \| :LspDefinition <CR>
" 	" nmap <silent> <buffer> gr :split \| :LspTypeDefintion <CR>
" 	" nmap <silent> <buffer> gi :split \| :LspImplementation <CR>
" 	" nmap <silent> <buffer> gt :split \| :LspReferences <CR>
"
"     nmap <buffer> <leader>rn <plug>(lsp-rename)
"     nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)
"
"     " refer to doc to add more commands
" endfunction
"
" augroup lsp_install
"     au!
"     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END

" LanguageClient-neovim setting

" Required for operations modifying multiple buffers like rename.
" set hidden
" set signcolumn=yes
" set completefunc=LanguageClient#complete
"
" let g:LanguageClient_serverCommands = {
"     \ 'ruby': ['solargraph', 'socket', '--port', '0'],
"     \ }
"
" nnoremap <silent>gd :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
" nnoremap <silent>gr :call LanguageClient#textDocument_rename()<CR>
" " nnoremap <silent><leader>gf
" nnoremap <silent>gt :call LanguageClient#textDocument_typeDefinition()<CR>
" nnoremap <silent>gr LanguageClient#textDocument_references()<CR>
" nmap <silent>K <Plug>(lcn-hover)

" nmap <F5> <Plug>(lcn-menu)
" " Or map each action separately
" nmap <silent>K <Plug>(lcn-hover)
" nmap <silent> gd <Plug>(lcn-definition)
" nmap <silent> <F2> <Plug>(lcn-rename)

set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd :call CocActionAsync('jumpDefinition', 'split')<CR>
nmap <silent> gt :call CocActionAsync('jumpTypeDefinition', 'split')<CR>
nmap <silent> gi :call CocActionAsync('jumpImplementation', 'split')<CR>
nmap <silent> gr <Plug>(coc-references)
nmap <silent> ga :CocAction()<CR>
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

