local builtin = require("telescope.actions")
return {
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        opts = {
            defaults = {
                file_ignore_patterns = {
                    "__pycache__/",
                    "__init__.py",
                    "node_modules/",
                    "deps",
                    "modules",
                    "_build",
                    "zig-pkg/tui*",
                },
                prompt_prefix = "   ",
                selection_caret = " ",
                entry_prefix = " ",
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    width = 0.87,
                    height = 0.80,
                },
                mappings = {
                    n = { ["q"] = builtin.close },
                    i = {
                        ["<Tab>"] = builtin.move_selection_next,
                        ["<S-Tab>"] = builtin.move_selection_previous,
                        ["<C-j>"] = builtin.move_selection_next,
                        ["<C-k>"] = builtin.move_selection_previous,
                        ["<Esc>"] = builtin.close,
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                aerial = {
                    col1_width = 4,
                    col2_width = 30,
                    format_symbol = function(symbol_path, filetype)
                        if filetype == "json" or filetype == "yaml" then
                            return table.concat(symbol_path, ".")
                        else
                            return symbol_path[#symbol_path]
                        end
                    end,
                    show_columns = "both",
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension "ui-select"
        end,
        keys = {
            { "<leader>ff", ":Telescope find_files<CR>",  silent = true, noremap = true, desc = "Telescope Find Files" },
            { "<leader>fb", ":Telescope buffers<CR>",     silent = true, noremap = true, desc = "Telescope Buffers" },
            { "<leader>fw", ":Telescope live_grep<CR>",   silent = true, noremap = true, desc = "Grep" },
            { "<leader>fs", ":Telescope aerial<CR>",      silent = true, noremap = true, desc = "Symbols" },
            { "<leader>fd", ":Telescope diagnostics<CR>", silent = true, noremap = true, desc = "Diagnostics" },
            {
                "<leader>fc",
                function()
                    require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
                end,
                silent = true,
                noremap = true,
                desc = "Config"
            }
        }
    }
}
