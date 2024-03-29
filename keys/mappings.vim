
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

nnoremap nt :NERDTreeToggle<CR>
nnoremap NT :NERDTreeFind<CR>

" which key mapping
"nnoremap <silent> \ :silent WhichKey '<Space>'<CR>
"vnoremap <silent> \ :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Buffer Navigation
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bNext<CR>
nnoremap <leader>c :bd<CR>

" LeaderF
"nnoremap <C-P> :LeaderfCommand<CR>
