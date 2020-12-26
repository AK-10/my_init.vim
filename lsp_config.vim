" vim-lsp config
" function! s:on_lsp_buffer_enabled() abort
"     setlocal omnifunc=lsp#complete
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
" "    nmap <buffer> gd <plug>(lsp-definition)
" "    nmap <buffer> gr <plug>(lsp-references)
" "    nmap <buffer> gi <plug>(lsp-implementation)
" "    nmap <buffer> gt <plug>(lsp-type-definition)
"     nmap <silent> gd :split \| :LspDefinition <CR>
"     nmap <silent> gr :split \| :LspReferences <CR>
"     nmap <silent> gi :split \| :LspImplementation <CR>
"     nmap <silent> gt :split \| :LspTypeDefintion <CR>
"     nmap <buffer> rn <plug>(lsp-rename)
"     nmap <buffer> [g <plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)
"     " refer to doc to add more commands
" endfunction

" augroup lsp_install
"     au!
"     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END

" let g:lsp_diagnostics_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
" let g:asyncomplete_auto_popup = 1
" let g:asyncomplete_popup_delay = 100
" let g:lsp_text_edit_enabled = 1

" " vim-lsp: rust
" if executable('rust-analyzer')
"      autocmd! BufNewFile,BufRead *.rs call lsp#register_server({
"         \ 'name': 'rust-analyzer',
"         \ 'cmd': {server_info->['rust-analyzer']},
"         \ 'whitelist': ['rust'],
"         \ })
" endif
"

" LanguageClient-neovim setting
" Required for operations modifying multiple buffers like rename.
set hidden
set signcolumn=yes
set completefunc=LanguageClient#complete

let g:LanguageClient_serverCommands = {
    \ 'ruby': ['solargraph', 'stdio'],
    \ 'rust': ['rust-analyzer'],
    \ }

nmap <silent>gd :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
nmap <silent><leader>gr :call LanguageClient#textDocument_rename()<CR>
nmap <silent>gt :call LanguageClient#textDocument_typeDefinition({'gotoCmd': 'split'})<CR>
nmap <silent>gr LanguageClient#textDocument_references({'gotoCmd': 'split'})<CR>
nmap <silent>K <Plug>(lcn-hover)

