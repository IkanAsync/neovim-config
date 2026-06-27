---@diagnostic disable: undefined-global
return {
    {
        "folke/flash.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            highlight = {
                backdrop = false,
            },
            modes = {
                char = {
                    highlight = { backdrop = false },
                },
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@diagnostic disable-next-line: undefined-doc-name
        ---@type snacks.Config
        opts = {
            dashboard = {
                enabled = true,
                sections = {
                    {
                        section = "terminal",
                        align = "center",
                        height = 26,
                        width = 72,
                        padding = 1,
                        cmd = "lolcat ~/.config/nvim/static/frieren.cat",
                    },
                    {
                        align = "center",
                        padding = 1,
                        text = {
                            { "  Update ", hl = "Label" },
                            { "  Sessions ", hl = "@property" },
                            { "  Last Session ", hl = "Number" },
                            { "  Files ", hl = "DiagnosticInfo" },
                            { "  Recent ", hl = "@string" },
                        },
                    },
                    { text = { "==============================================================" } },
                    {
                        section = "keys",
                        indent = 1,
                        align = "center",
                        gap = 0.5,
                        padding = 1,
                    },

                    { text = { "===============================================================" } },
                    height = 60,
                },
            },
            explorer = { enabled = false },
            indent = { enabled = true },
            input = {
                enabled = true,
            },
            picker = {
                enabled = false,
                win = {
                    input = {
                        keys = {
                            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
                            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
                        },
                    },
                },
            },
            notifier = { enabled = false },
            quickfile = { enabled = true },
            lazygit = { enabled = true },
        },
    },
}
