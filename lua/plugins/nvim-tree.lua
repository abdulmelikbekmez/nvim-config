return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        cmd = "NvimTreeToggle",
        opts = function()
            local tree_cb = require("nvim-tree.config").nvim_tree_callback
            return {
                disable_netrw = true,
                hijack_netrw = true,
                -- auto_close = true,
                open_on_tab = false,
                hijack_cursor = false,
                update_cwd = true,
                -- update_to_buf_dir = {
                --     enable = true,
                --     auto_open = true,
                -- },
                diagnostics = {
                    enable = true,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                    ignore_list = {},
                },
                system_open = {
                    cmd = nil,
                    args = {},
                },
                filters = {
                    dotfiles = false,
                    custom = {},
                },
                git = {
                    enable = true,
                    ignore = true,
                    timeout = 500,
                },
                view = {
                    width = 30,
                    hide_root_folder = false,
                    side = "right",
                    mappings = {
                        custom_only = false,
                        list = {
                            { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
                            { key = "h",                  cb = tree_cb("close_node") },
                            { key = "v",                  cb = tree_cb("vsplit") },
                        },
                    },
                    number = false,
                    relativenumber = false,
                },
                trash = {
                    cmd = "trash",
                    require_confirm = true,
                },
                -- show_icons = {
                --     git = 1,
                --     folders = 1,
                --     files = 1,
                --     folder_arrows = 1,
                --     tree_width = 30,
                -- },


            }
        end
    }
}
