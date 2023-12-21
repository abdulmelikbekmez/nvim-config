return {
    -- Formatter
    {
        'stevearc/conform.nvim',
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
                border = "none",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "folke/neoconf.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        opts = function()
            local signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = " " },
                { name = "DiagnosticSignInfo", text = " " },
            }
            return {
                signs = signs,
                ensure_installed = { "rust_analyzer", "pyright", "ruff-lsp", "lua_ls" },
                config = {
                    virtual_text = true,
                    -- show signs
                    signs = {
                        active = signs,
                    },
                    update_in_insert = true,
                    underline = true,
                    severity_sort = true,
                    float = {
                        focusable = false,
                        style = "minimal",
                        border = "rounded",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                },
            }
        end,
        config = function(_, opts)
            for _, sign in ipairs(opts.signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end

            vim.diagnostic.config(opts.config)

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            --[[ vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, ]]
            --[[         { border = "rounded" }) ]]
            local function lsp_keymaps(bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
                end
                nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                --[[ nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition") ]]
                nmap("K", vim.lsp.buf.hover, "Hover")
                nmap("gI", function() require("telescope.builtin").lsp_implementations() end, "[G]oto [I]mplementation")
                nmap("<c-k>", vim.lsp.buf.signature_help, "Signature Help")
                nmap("gr", function() require("telescope.builtin").lsp_references() end, "[G]oto [R]eferences")
            end

            local on_attach = function(_client, bufnr)
                lsp_keymaps(bufnr)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({ ensure_installed = opts.ensure_installed })
            mason_lspconfig.setup_handlers({
                function(server)
                    local options = {
                        on_attach = on_attach,
                        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
                    }

                    require("lspconfig")[server].setup(options)
                end
            })
        end,
    }

}
