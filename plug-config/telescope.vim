
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader><leader>h <cmd>Telescope help_tags<cr>
nnoremap <C-P> <cmd>Telescope commands<cr>
nnoremap <M-r> <cmd>Telescope registers<cr>
nnoremap gu <cmd>Telescope lsp_references<cr>
nnoremap <leader>r <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>R <cmd>Telescope treesitter<cr>
nnoremap ga <cmd>Telescope lsp_code_actions<cr>
nnoremap <leader>e <cmd>Telescope diagnostics<cr>
nnoremap gi <cmd>Telescope lsp_implementations<cr>
nnoremap gd <cmd>Telescope lsp_definitions<cr>
nnoremap gD <cmd>Telescope lsp_type_definitions<cr>

lua <<EOF

require('telescope').setup({
    defaults = {
        layout_strategy = 'vertical',
        layout_config = { height = 0.95 },
        path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            return string.format("%s (%s)", tail, path)
        end,
        file_ignore_patterns = {"%.meta","%.asset","%.unity","%.mat","%.prefab"},
        mappings = {
            n = { 
                    ['<c-d>'] = require('telescope.actions').delete_buffer 
                }, -- n
            i = {
                    ["<C-h>"] = "which_key",
                    ['<c-d>'] = require('telescope.actions').delete_buffer
            } -- i
        },
    },
    pickers = {
        find_files = {
            find_command = { "fd", "-t", "f"}
        }
    }
})
EOF
