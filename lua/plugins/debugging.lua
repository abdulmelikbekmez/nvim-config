return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            config = function()
                local dapui = require("dapui")
                dapui.setup()
            end
        },
        keys = {
            { "<F5>",       "<cmd> DapContinue <cr>",         desc = "Continue debugging" },
            { "<F9>",       "<cmd> DapTerminate <cr>",        desc = "Terminate debugging" },
            { "<F10>",      "<cmd> DapStepOver <cr>",         desc = "Step Over" },
            { "<F11>",      "<cmd> DapStepInto <cr>",         desc = "Step Into" },
            { "<F12>",      "<cmd> DapStepOut <cr>",          desc = "Step Out" },

            { "<leader>db", "<cmd> DapToggleBreakpoint <cr>", desc = "Toggle BreakPoint" },
            { "<leader>dr", "<cmd> DapToggleRepl <cr>",       desc = "Toggle Repl" },
        },
        config = function(_, _)
            local dap = require("dap")
            local dapui = require("dapui")

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
            vim.fn.sign_define('DapStopped',
                { text = "ﰲ", texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })



            dap.adapters.python = {
                type = 'executable',
                command = "debugpy-adapter",
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
                    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = 'launch',
                    name = "main.py",

                    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                    -- program = "${file}"; -- This configuration will launch the current file if used.
                    program = "main.py",
                    pythonPath = getPythonPath
                },
                {
                    -- The first three options are required by nvim-dap
                    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = 'launch',
                    name = "Current File",

                    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                    -- program = "${file}"; -- This configuration will launch the current file if used.
                    program = "${file}",
                    pythonPath = getPythonPath
                }
            }

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
        end
    }
}
