syntax enable
set nowrap
set noswapfile
set number 
set relativenumber
set splitbelow
set splitright
set noshowmode
set incsearch
set wildmenu
let mapleader="\<space>"

set updatetime=300
set timeoutlen=200

" Indent
set expandtab
set tabstop=4
set shiftwidth=4
set cinkeys-=:

" Enable the mouse
set mouse=a

"set autochdir
set clipboard=unnamedplus

" all utf-8
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

syntax on
filetype indent plugin on 
filetype plugin on

set updatetime=1000
set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
set previewheight=5
set termguicolors
noremap H ^
noremap L $

noremap <leader>y "*y
noremap <leader>Y "*Y
noremap <leader>p "*p
noremap <leader>P "*P

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize +2<CR>
nnoremap <M-l>    :vertical resize -2<CR>

" Redraw the screen and clear any search terms
noremap <silent> <c-n> :nohls<cr><c-l>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer Navigation
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bNext<CR>
nnoremap <leader>c :bd<CR>
