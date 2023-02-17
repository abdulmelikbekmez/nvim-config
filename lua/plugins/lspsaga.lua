return {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    keys = {
        { "gd",         "<cmd> Lspsaga goto_definition<cr>",      desc = "Go to Definition" },

        { "<leader>lj", "<cmd> Lspsaga diagnostic_jump_next<cr>", desc = "Next Diagnostic" },
        { "<leader>lk", "<cmd> Lspsaga diagnostic_jump_prev<cr>", desc = "Prev Diagnostic" },
        { "<leader>lt", "<cmd> Lspsaga outline<cr>",              desc = "Toggle Outline" },
        { "<leader>lf", "<cmd> Lspsaga lsp_finder<cr>",           desc = "Lsp Finder" },
        { "<leader>la", "<cmd> Lspsaga code_action<cr>",          desc = "Code Action" }
    },
    config = function()
        require("lspsaga").setup({})
    end,
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" }
    }
}
