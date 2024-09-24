return {
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline", -- cmdline completions
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "onsails/lspkind.nvim"
        },
        config = function(_, opt)
            local cmp = require("cmp")

            cmp.setup(opt)

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,

        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            local kind_score = {
                Field = 1,
                Variable = 2,
                Class = 3,
                Method = 4,
                Keyword = 5
            }

            local kind_mapper = require("cmp.types").lsp.CompletionItemKind

            local kind_score_sorter = function(entry1, entry2)
                local kind1 = kind_score[kind_mapper[entry1:get_kind()]] or 100
                local kind2 = kind_score[kind_mapper[entry2:get_kind()]] or 100

                if kind1 < kind2 then
                    return true
                end
            end

            local kind_icons = {
                Array = " ",
                Boolean = " ",
                Class = "",
                Color = "",
                Constant = "",
                Constructor = "",
                Copilot = " ",
                Enum = "",
                EnumMember = "",
                Event = "",
                Field = "",
                File = "",
                Folder = "󰉋",
                Function = "",
                Interface = "",
                Key = " ",
                Keyword = "󰌋",
                Method = "m",
                Module = "",
                Namespace = " ",
                Null = "ﳠ ",
                Number = " ",
                Object = " ",
                Operator = "",
                Package = " ",
                Property = "",
                Reference = " ",
                Snippet = " ",
                String = " ",
                Struct = " ",
                Text = " ",
                TypeParameter = " ",
                Unit = "",
                Value = "",
                Variable = " ",
            }
            return {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry,
                            vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"

                        return kind
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 10 },
                    { name = "luasnip",  priority = 9 },
                    { name = "path",     priority = 8 },
                    { name = "buffer",   priority = 7, keyword_length = 5 },
                }),
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                sorting = {
                    priority_weight = 1.0,
                    comparators = {
                        cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
                        cmp.config.compare.locality,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.offset,
                        cmp.config.compare.order,
                    }
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                    completion = {
                        -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                }
            }
        end,
    }
}
