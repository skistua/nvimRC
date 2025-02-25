return {
    'preservim/nerdcommenter',
    'tpope/vim-surround',
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    { 'lukas-reineke/indent-blankline.nvim',
    config = function()
        require("ibl").setup {
            scope = {
                enabled = false
            }
        }
    end
},
{
    "numToStr/FTerm.nvim",
    config = function()
        require'FTerm'.setup({
            border = 'double',
            dimensions  = {
                height = 0.9,
                width = 0.9,
            },
            cmd = os.getenv('SHELL')
        })

        vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
        vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
        vim.keymap.set('n', '<M-i>', '<CMD>lua require("FTerm").toggle()<CR>')
        vim.keymap.set('t', '<M-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
    end
}
}
