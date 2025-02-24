return {

-- TreeSitter
  {
      'nvim-treesitter/nvim-treesitter',
      build = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,

      config = function() 
        require'nvim-treesitter.configs'.setup {
            -- Modules and its options go here
            highlight = {
                enable = true ,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = { enable = true },
            textobjects = { enable = true },
        }

        --floding
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
        -- no folding default
        vim.wo.foldlevel = 99
      end 
  },

  'nvim-treesitter/nvim-treesitter-context'
}