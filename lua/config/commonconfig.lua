
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- options
vim.cmd('syntax enable')

local o = vim.o
local g = vim.g
local opt = vim.opt

o.wrap = false
o.swapfile = false
o.number = true
o.relativenumber = true
o.splitbelow = true
o.splitright = true
o.showmode = false
o.incsearch = true
o.wildmenu = true
g.mapleader = ' '
g.maplocalleader = "\\"

o.updatetime = 1000
o.timeoutlen = 200
o.completeopt = 'longest,menuone,preview'

-- Indent
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

-- Enable the mouse
o.mouse = 'a'

-- set autochdir
opt.clipboard = 'unnamedplus'

-- all utf-8
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
--opt.termencoding = 'utf-8'

-- background
opt.background = 'dark'

vim.cmd [[
syntax on
filetype indent plugin on 
filetype plugin on
]]

-- Set desired preview window height for viewing documentation.
opt.previewheight=5
opt.termguicolors = true

if vim.fn.has('win32') == 1 then
    g.python3_host_prog = '~/.config/nvimvenv/Scripts/python.exe'
else
    g.python3_host_prog = '~/.config/nvimvenv/bin/python'
end


-- Define an autocommand group for HLSL filetype detection
vim.api.nvim_exec([[
  augroup hlsl
    autocmd!
    autocmd BufRead,BufNewFile *.hlsl set filetype=hlsl
  augroup END
]], false)

-- common key map
local map = vim.api.nvim_set_keymap
local option = { noremap = true, silent = true }

map('n', 'H', '^', option)
map('n', 'L', '$', option)

map('n', '<leader>y', '"*y', option)
map('n', '<leader>Y', '"*Y', option)
map('n', '<leader>p', '"*p', option)
map('n', '<leader>P', '"*P', option)

-- Redraw the screen and clear any search terms
map('n', '<C-n>', ':nohls<cr><c-l>', option)

-- Better window navigation
map('n', '<C-h>', '<C-w>h', option)
map('n', '<C-j>', '<C-w>j', option)
map('n', '<C-k>', '<C-w>k', option)
map('n', '<C-l>', '<C-w>l', option)

-- Use alt + hjkl to resize windows
map('n', '<M-j>', ':resize -2<CR>', option)
map('n', '<M-k>', ':resize +2<CR>', option)
map('n', '<M-h>', ':vertical resize +2<CR>', option)
map('n', '<M-l>', ':vertical resize -2<CR>', option)

-- Buffer Navigation
map('n', '<leader>l', ':bnext<CR>', option)
map('n', '<leader>h', ':bNext<CR>', option)
map('n', '<leader>c', ':bd<CR>', option)

map('i', 'jk', '<ESC>', option)
