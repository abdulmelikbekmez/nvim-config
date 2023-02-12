local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


-- Install your plugins here
require("lazy").setup({
    -- My plugins here
    "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
    "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
    "numToStr/Comment.nvim", -- Easily comment stuff
    "kyazdani42/nvim-web-devicons",
    "kyazdani42/nvim-tree.lua",
    "akinsho/bufferline.nvim",
    "moll/vim-bbye",
    "nvim-lualine/lualine.nvim",
    "akinsho/toggleterm.nvim",
    "ahmedkhalf/project.nvim",
    "lewis6991/impatient.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "goolord/alpha-nvim",
    "antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
    "folke/which-key.nvim",

    -- Colorschemes
    -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
    -- use "lunarvim/darkplus.nvim"

    "Mofiqul/vscode.nvim",
    "EdenEast/nightfox.nvim", -- Packer
    -- use("projekt0n/github-nvim-theme")
    "shaunsingh/nord.nvim",


    -- cmp plugins
    "hrsh7th/nvim-cmp", -- The completion plugin
    "hrsh7th/cmp-buffer", -- buffer completions
    "hrsh7th/cmp-path", -- path completions
    "hrsh7th/cmp-cmdline", -- cmdline completions
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    "hrsh7th/cmp-nvim-lsp",

    -- snippets
    "L3MON4D3/LuaSnip", --snippet engine
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use

    -- LSP
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    --[[ use({ ]]
    --[[     "glepnir/lspsaga.nvim", ]]
    --[[     branch = "main", ]]
    --[[     config = function() ]]
    --[[         require("lspsaga").setup({}) ]]
    --[[     end, ]]
    --[[     requires = { { "nvim-tree/nvim-web-devicons" } } ]]
    --[[ }) ]]
    "tamago324/nlsp-settings.nvim", -- language server settings defined in json for
    "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
    "RRethy/vim-illuminate",

    -- Telescope
    "nvim-telescope/telescope.nvim",
    'nvim-telescope/telescope-ui-select.nvim',


    -- Treesitter and UI
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    },
    "JoosepAlviste/nvim-ts-context-commentstring",

    "rcarriga/nvim-notify",
    'stevearc/dressing.nvim',
    {
        "folke/noice.nvim",
        opt = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    signature = {
                        enabled = false
                    },
                    hover = {
                        enabled = false
                    }

                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end,
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },

    -- Task Management
    {
        'stevearc/overseer.nvim',
    },

    -- Git
    "lewis6991/gitsigns.nvim",

    -- Signature
    "ray-x/lsp_signature.nvim",

    -- Debugging
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",

})
