return {
    {
        'stevearc/overseer.nvim',
        config = function(_, _)
            require("overseer").setup()
        end,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "stevearc/dressing.nvim",
            "rcarriga/nvim-notify",
        }
    }
}
