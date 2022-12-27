local ok, dap = pcall(require, "dap")
if not ok then
    return
end

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = 'OpenDebugAD7',
    --[[ options = { ]]
    --[[     detached = false ]]
    --[[ } ]]
}
dap.configurations.cpp = {
    {
        name = "Current file",
        type = "cppdbg",
        request = "launch",
        program = "${fileBasenameNoExtension}",
        cwd = '${workspaceFolder}',
        linux = {
            MIMode = "gdb",
            miDebuggerPath = "/usr/bin/gdb"
        },
        stopAtEntry = true,
    },
    {
        name = "Selected File",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        linux = {
            MIMode = "gdb",
            miDebuggerPath = "/usr/bin/gdb"
        },
        stopAtEntry = true,
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

dap.configurations.c = dap.configurations.cpp
