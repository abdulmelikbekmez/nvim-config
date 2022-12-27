local ok, dap = pcall(require, "dap")
if not ok then
    return
end

dap.adapters.python = {
    type = 'executable';
    command = "debugpy-adapter";
}

local function getPythonPath()
    -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
    -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
    local cwd = vim.fn.getcwd()
    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
    elseif vim.fn.executable('/usr/bin/python3') == 1 then
        return '/usr/bin/python3'
    else
        return '/usr/bin/python'
    end

end

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch';
        name = "main.py";

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        -- program = "${file}"; -- This configuration will launch the current file if used.
        program = "main.py";
        pythonPath = getPythonPath
    },
    {
        -- The first three options are required by nvim-dap
        type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch';
        name = "Current File";

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        -- program = "${file}"; -- This configuration will launch the current file if used.
        program = "${file}";
        pythonPath = getPythonPath
    }
}
