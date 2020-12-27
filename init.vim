" DO NOT ERASE!!!
" runtime for neovim 0.5
let $VIMRUNTIME=expand("$HOME/works/neovim/runtime")
set runtimepath+=~/works/neovim/runtime

" save clipboard yanked content
set clipboard+=unnamed,unnamedplus

" must be after set [no]compatible
set whichwrap=b,s,h,l,<,>,[,],~

set number
set smartindent
set mouse=a
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline
set hidden
set termguicolors

syntax enable
filetype plugin indent on

" vim plug
call plug#begin('~/.config/nvim/plugged')
" file explorer
Plug 'lambdalisue/fern.vim'
" for fix fern issue: https://github.com/lambdalisue/fern.vim/issues/120
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-hijack.vim'

" fizzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" awesome bottom menu bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" solarized theme
Plug 'overcache/NeoSolarized'

Plug 'acarapetis/vim-colors-github'

" enable :XtermColorTable
Plug 'guns/xterm-color-table.vim'
Plug 'Yggdroot/indentLine' "visualize indent
Plug 'bronson/vim-trailing-whitespace' "highlight unnecessary white-space

" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

" lsp
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" auto complete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'rust-lang/rust.vim'
Plug 'morhetz/gruvbox'

" git utilities
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
call plug#end()


" config for FixCursorHold.nvim
" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime=50

" config for airline
let g:airline#extensions#tabline#enabled=1

" TUI only
if !($NVIM_GUI)
  colorscheme my_muon
  let g:airline_theme='papercolor'
endif

" ========== deoplete ==========
let g:deoplete#enable_at_startup = 1
set completeopt=menuone
" ==============================

" ========== fzf ==========
" fzf mapping
nnoremap <C-p> :FZFFileList<CR>
nnoremap <C-b> :Buffers<CR>
command! FZFFileList call fzf#run(fzf#wrap({
            \ 'source': 'find . -type d -name .git -prune -o ! -name .DS_Store'}))

let g:fzf_buffers_jump=1

command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" =========================

" ========== ripgrep ==========
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" fire fzf when called Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" mapping :Rg
nnoremap <C-g> :Rg<CR>
" ============================

" ========== Fern ==========
nnoremap <silent><C-n> :Fern . -drawer -reveal=% -toggle <CR>
let g:fern#default_hidden=1
let g:fern#renderer='nerdfont'
" ==========================

" ========== NeoSolarized ==========
set termguicolors

let g:neosolarized_contrast='normal'
let g:neosolarized_visibility='normal'
let g:neosolarized_vertSplitBgTrans=1
let g:neosolarized_bold=1
let g:neosolarized_underline=1
let g:neosolarized_italic=1
let g:neosolarized_termBoldAsBright=1
" ==================================

" read lsp config file
runtime! lsp_config.vim

" tab utility
nnoremap tn :tabnew<CR>
nnoremap th :tabprevious<CR>
nnoremap tl :tabnext<CR>
nnoremap tH :-tabmove<CR>
nnoremap tL :+tabmove<CR>

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.swift setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.rs setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.json setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" mapleader
let mapleader=','
nnoremap <Leader>e :Explore<CR>
nnoremap <Leader>se :Sexplore<CR>
nnoremap <Leader>ve :Vexplore<CR>
