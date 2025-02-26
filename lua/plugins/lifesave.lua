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
  "keaising/im-select.nvim",
  lazy = false,
  opts = {
      default_im_select = (function ()
        local os_name = vim.loop.os_uname().sysname
        if os_name == "Windows_NT" then
            return "1003"
        else
            return  "com.apple.keylayout.ABC"
        end
      end)(),
    default_command = "im-select",
  },
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
