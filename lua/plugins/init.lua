return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {}
    },

    {
        "Aasim-A/scrollEOF.nvim",
        event = { "CursorMoved", "WinScrolled" },
        opts = {}
    },
    {
        'nvim-mini/mini.notify',
        version = '*'
        ,
        opts = {}
    },

    {
        'nvim-mini/mini.pairs',
        version = '*',
        opts = {}
    },
    {
        "nvim-mini/mini.surround",
        event = { "BufReadPre", "BufNewFile" },
        opts = {}
    },
    {
        "stevearc/oil.nvim",

        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
        opts = {
            float = {
                preview_split = "right",
            },
            skip_confirm_for_simple_edits = true,
            keymaps = {
                ["q"] = { "actions.close", mode = "n" },
                ["gd"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        ---@diagnostic disable-next-line: lowercase-global
                        detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                },
            },
        },
        keys = {
            { "<leader>e", "<cmd>Oil --preview --float<CR>", desc = "Oil", silent = true }
        }

    },
    {
        'vieitesss/miniharp.nvim',
        version = '*',
        opts = {
            autoload = true,
            autosave = true,
            show_on_autoload = false,
            notifications = true,
            ui = {
                position = 'top-right', -- `top-left`, `top-right`, `bottom-left`, `bottom-right`.
                show_hints = true,
                enter = true,           -- Whether to enter the floating window or not
            },
        },
    },
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        opts = {

            size = 20,
            open_mapping = [[<c-f>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = false,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "rounded",
                width = 150,
                height = 45,
                winblend = 0,
            },
        }
    },
    {
        "ojroques/nvim-bufdel",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
        keys = {

            { "<leader>bd", ":BufDel<CR>",       silent = true, noremap = true, desc = "Delete buffer" },
            { "<leader>bo", ":BufDelOthers<CR>", silent = true, noremap = true, desc = "Delete buffer" }
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                delete = { text = "󰍵" },
                changedelete = { text = "󱕖" },
            },
        }
    },
    {
        'stevearc/aerial.nvim',
        opts = {

            backends = { "treesitter", "lsp" },
            filter_kind = false,
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    }

}
