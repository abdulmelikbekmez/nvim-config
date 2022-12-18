local M = {}

-- TODO: backfill this to template
M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {

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
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end


local function lsp_keymaps(bufnr)

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("K", vim.lsp.buf.hover, "Hover")
    nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    nmap("<c-k>", vim.lsp.buf.signature_help, "Signature Help")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
end

M.on_attach = function(client, bufnr)
    --[[ if client.name == "tsserver" or client.name == "jsonls" then ]]
    --[[     client.server_capabilities.documentFormattingProvider = false ]]
    --[[ end ]]
    lsp_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
