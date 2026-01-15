return {
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
		},
		cmd = "Telescope",

		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find file" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
			{ "<leader>fs", "<cmd>Telescope aerial<CR>", desc = "Symbols" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
			{ "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Find word" },
		},

		opts = {
			defaults = {
				file_ignore_patterns = {
					"__pycache__/",
					"__init__.py",
					"node_modules/",
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
					n = { ["q"] = require("telescope.actions").close },
					i = {
						["<Tab>"] = require("telescope.actions").move_selection_next,
						["<S-Tab>"] = require("telescope.actions").move_selection_previous,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<Esc>"] = require("telescope.actions").close,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
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
			require("telescope").load_extension("ui-select")
		end,
	},
}
