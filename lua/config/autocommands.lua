local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = augroup("Highlight Yank"),
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("Wrap Spell"),
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = augroup("Sdf to Xml"),
    pattern = "*.sdf",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "xml")
    end
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("Close With Q"),
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Auto Format
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("Auto Format"),
    callback = function()
        vim.lsp.buf.format()
    end
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("Dap Autocompletion"),
    pattern = "dap-repl",
    callback = function()
        require("dap.ext.autocompl").attach()
    end,
})
