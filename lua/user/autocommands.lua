vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
    end,
    group = vim.api.nvim_create_augroup("Auto Formatting", { clear = true })
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("Dap Autocompletion", { clear = true }),
    pattern = "dap-repl",
    callback = function()
        require("dap.ext.autocompl").attach()
    end,
})
