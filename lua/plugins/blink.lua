return {
    'saghen/blink.cmp',
    -- enabled = false,
    dependencies = {
        'saghen/blink.lib',

        { "windwp/nvim-autopairs", opts = {} },
        'rafamadriz/friendly-snippets',
        {
            "L3MON4D3/LuaSnip",
            dependencies = "rafamadriz/friendly-snippets",
            opts = { history = true, updateevents = "TextChanged,TextChangedI" },
            config = function(_, opts)
                require("luasnip").config.set_config(opts)
                require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
                require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

                require("luasnip.loaders.from_snipmate").load()
                require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

                require("luasnip.loaders.from_lua").load()
                require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

                vim.api.nvim_create_autocmd("InsertLeave", {
                    callback = function()
                        if
                            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                            and not require("luasnip").session.jump_active
                        then
                            require("luasnip").unlink_current()
                        end
                    end,
                })
            end,
        },
    },

    build = function()
        require('blink.cmp').build():pwait()
    end,

    opts = {
        completion = {
            documentation = { auto_show = false },
            menu = {
                border = 'rounded',
                draw = {
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },

            ghost_text = { enabled = false },
            list = {
                selection = {
                    auto_insert = false,
                },
            },
        },

        snippets = {
            preset = "luasnip"
        },

        keymap = {
            preset = "default",
            ["<CR>"] = { "accept", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },

            providers = {
                lsp = {
                    override = {
                        get_trigger_characters = function(self)
                            local trigger_chars = self:get_trigger_characters()
                            vim.list_extend(trigger_chars, { '~', '?', '!' })
                            return trigger_chars
                        end,
                    }
                }
            }

        },

        fuzzy = { implementation = "rust" }
    },
}
