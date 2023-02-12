local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
    return
end
local ok_mason_lsp_config, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lsp_config then
    return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        border = "none",
    },
})
mason_lspconfig.setup({
    ensure_installed = { "rust_analyzer", "pyright" },
})

local handlers = require("user.lsp.handlers")

local configured_servers = { "jsonls", "lua-language-server", "texlab", "jdtls" }

mason_lspconfig.setup_handlers({
    function(server)
        local opts = {
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
        }

        for _, s in ipairs(configured_servers) do
            if server == s then
                local server_opts = require(table.concat({ "user.lsp.settings", s }, "."))
                opts = vim.tbl_deep_extend("force", server_opts, opts)
            end
        end

        require("lspconfig")[server].setup(opts)
    end,
})

handlers.setup()
require("user.lsp.null-ls")
require("user.lsp.luasnip")
