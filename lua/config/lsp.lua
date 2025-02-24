require('mason').setup()
require('mason-lspconfig').setup()

local base_on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = { noremap = true, silent = true }

    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'g\\', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>==', '<cmd>lua vim.lsp.buf.format {async = true}<CR>', opts)
    buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    --buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    --buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    --buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    --buf_set_keymap('n', 'gu', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    -- Hover display diagnostic message
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local floatOpts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, floatOpts)
      end
    })

    -- Hover hightlight symbol
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd [[
        hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        ]]
        vim.api.nvim_create_augroup('lsp_document_highlight', {
            clear = false
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight',
        })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup_handlers {
    function(server_name)  -- default handler (optional)
        require("lspconfig")[server_name].setup {
            --on_attach = on_attach,
            capabilities = capabilities,
            on_attach = function(clien,bufnr)
                base_on_attach(clien,bufnr)
                vim.api.nvim_buf_set_keymap(bufnr,'n','gd'
                    ,'<cmd> lua require("telescope.builtin").lsp_definitions()<CR>'
                    ,{ noremap = true, silent = true })
            end
        }
    end,
    ['omnisharp'] = function()
        require("lspconfig").omnisharp.setup {
            handlers = {
                ["textDocument/definition"] = require('omnisharp_extended').handler,
            },
            --on_attach = on_attach
            on_attach = function(clien,bufnr)
                base_on_attach(clien,bufnr)
                vim.api.nvim_buf_set_keymap(bufnr,'n','gd'
                    ,'<cmd> lua require("omnisharp_extended").telescope_lsp_definitions()<CR>'
                    ,{ noremap = true, silent = true })
            end
        }
    end,
    ['csharp_ls'] = function()
        local lspconfig = require("lspconfig")
        lspconfig.csharp_ls.setup {
            handlers = {
                ["textDocument/definition"] = require('csharpls_extended').handler
            },
            root_dir = function(startpath)
                return lspconfig.util.root_pattern("*.sln")(startpath)
                    or lspconfig.util.root_pattern("*.csproj")(startpath)
                    or lspconfig.util.root_pattern("*.fsproj")(startpath)
                    or lspconfig.util.root_pattern(".git")(startpath)
            end,
            --on_attach = on_attach
            on_attach = function(clien,bufnr)
                base_on_attach(clien,bufnr)
                vim.api.nvim_buf_set_keymap(bufnr,'n','gd'
                    ,'<cmd> lua require("csharpls_extended").lsp_definitions()<CR>'
                    ,{ noremap = true, silent = true })
            end
        }
    end,
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
