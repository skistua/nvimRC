return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
        opts = {
            provider = "sfQwen",
            vendors = {
                sfQwen = {
                    __inherited_from = "openai",
                    api_key_name = "SF_API_KEY",
                    endpoint = "https://api.siliconflow.cn/v1",
                    model = "Qwen/Qwen2.5-32B-Instruct",
                },
                deepseek = {
                    __inherited_from = "openai",
                    api_key_name = "DEEPSEEK_API_KEY",
                    endpoint = "https://api.deepseek.com",
                    model = "deepseek-chat",
                },
            },
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = (function()
            local os_name = vim.loop.os_uname().sysname
            if os_name == "Windows_NT" then
                return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            else
                return "make"
            end
        end)(),

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            --"echasnovski/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            --"ibhagwan/fzf-lua", -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            --"zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
    {
        'huggingface/llm.nvim',
        config = function()
            local llm = require('llm')
            llm.setup({
            api_token = 'sk-bxamionvdhhvnjdjrneadewovsvetvewqfiokpdzniepbzei', -- cf Install paragraph
            model = "Qwen/Qwen2.5-Coder-32B-Instruct", -- the model ID, behavior depends on backend
            backend = "openai", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
            url = "https://api.siliconflow.cn", -- the http url of the backend
            tokens_to_clear = { "<|endoftext|>" }, -- tokens to remove from the model's output
            -- parameters that are added to the request body, values are arbitrary, you can set any field:value pair here it will be passed as is to the backend
            request_body = {
                parameters = {
                    max_new_tokens = 100,
                    temperature = 0.2,
                    top_p = 0.95,
                },
            },
            -- set this if the model supports fill in the middle
            fim = {
                enabled = true,
                prefix = "<|fim_prefix|>",
                middle = "<|fim_middle|>",
                suffix = "<|fim_suffix|>",
            },
            debounce_ms = 300,
            accept_keymap = "<M-\\>",
            dismiss_keymap = "<S-Tab>",
            tls_skip_verify_insecure = false,
            -- llm-ls configuration, cf llm-ls section
            lsp = {
                bin_path = (function ()
                    local os = vim.loop.os_uname().sysname
                    if os == "Windows_NT" then
                       return vim.fn.stdpath('data') .. "/mason/bin/llm-ls.cmd"
                    else
                       return vim.fn.stdpath('data') .. "/mason/bin/llm-ls"
                    end

                end)()
            },
            tokenizer = nil, -- cf Tokenizer paragraph
            context_window = 1024, -- max number of tokens for the context window
            enable_suggestions_on_startup = true,
            enable_suggestions_on_files = "*", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
            disable_url_path_completion = false, -- cf Backend
            })
        end
    }
    --{
        --'Exafunction/codeium.vim',
        --config = function ()
            --vim.g.codeium_disable_bindings = 1
            ---- Change '<C-g>' here to any keycode you like.
            --vim.keymap.set('i', '<M-v>', function () return vim.fn['codeium#Accept']() end, { expr = true })
            --vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
            --vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
            --vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
        --end
    --}
}
