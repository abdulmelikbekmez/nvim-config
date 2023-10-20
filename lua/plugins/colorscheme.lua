return {
    {
        "Mofiqul/vscode.nvim",
        enabled = true,
        config = function(_, opts)
            vim.o.background = 'dark'
            local vscode = require("vscode")
            vscode.setup(opts)
        end,
        opts = function()
            local c = require('vscode.colors').get_colors()
            return {
                -- Enable transparent background
                transparent = true,
                -- Enable italic comment
                italic_comments = true,
                -- Disable nvim-tree background color
                disable_nvimtree_bg = true,
                -- Override colors (see ./lua/vscode/colors.lua)
                color_overrides = {
                    vscLineNumber = '#FFFFFF',
                },
                -- Override highlight groups (see ./lua/vscode/theme.lua)
                group_overrides = {
                    -- this supports the same val table as vim.api.nvim_set_hl
                    -- use colors from this colorscheme by requiring vscode.colors!
                    Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
                }
            }
        end
    },
    {
        "EdenEast/nightfox.nvim",
        enabled = true,
        config = function(_, _)
            vim.cmd("colorscheme nordfox")
        end
    },
    {
        'folke/tokyonight.nvim',
        enabled = true,
        config = function(_, _)
            vim.cmd("colorscheme tokyonight")
        end
    },
    {
        "sainnhe/sonokai",
        enabled = true,
        config = function(_, _)
            vim.cmd("colorscheme sonokai")
        end
    }
}
