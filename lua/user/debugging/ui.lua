local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
    return
end

local ok_dapui, dapui = pcall(require, "dapui")
if not ok_dapui then
    return
end

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

-- Icon Section
vim.fn.sign_define('DapBreakpoint',
    { text = "", texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapStopped', { text = "ﰲ", texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
