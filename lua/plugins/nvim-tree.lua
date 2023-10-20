return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    opts = function()
        return {
            view = {
                side = "right",
            },
            diagnostics = {
                enable = true
            }
        }
    end,
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end
}
