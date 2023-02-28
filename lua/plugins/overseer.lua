return {
    {
        'stevearc/overseer.nvim',
        keys = {
            { "<leader>ot", "<cmd>OverseerToggle<cr>",       desc = "Toggle Task Editor" },
            { "<leader>oa", "<cmd>OverseerTaskAction<cr>",   desc = "Action" },
            { "<leader>ob", "<cmd>OverseerBuild<cr>",        desc = "Build" },
            { "<leader>or", "<cmd>OverseerRun<cr>",          desc = "Run" },
            { "<leader>os", "<cmd>OverseerSaveBundle<cr>",   desc = "Save Bundle" },
            { "<leader>ol", "<cmd>OverseerLoadBundle<cr>",   desc = "Load Bundle" },
            { "<leader>od", "<cmd>OverseerDeleteBundle<cr>", desc = "Delete Bundle" },

            { "<F4>",       "<cmd>OverseerRun<cr>",          desc = "Overseer Run" },
        },
        config = function(_, opts)
            require("overseer").setup(opts)
        end,
        opts = {},
        dependencies = {
            "stevearc/dressing.nvim",
            "rcarriga/nvim-notify",
        }
    }
}
