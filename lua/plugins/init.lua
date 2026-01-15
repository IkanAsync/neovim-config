return {

	{
		"stevearc/aerial.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},

	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		float = {
			preview_split = "right",
		},
		opts = {
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
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
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
			direction = "float", -- bisa '', 'vertical', 'tab', 'float'
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "rounded",
				width = 150,
				height = 45,
				winblend = 0,
			},
		},
	},

	{
		"nvim-mini/mini.surround",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
			ensure_installed = {
				"roslyn",
			},
			PATH = "skip",

			ui = {
				icons = {
					package_pending = " ",
					package_installed = " ",
					package_uninstalled = " ",
				},
			},

			max_concurrent_installers = 10,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",

			"williamboman/mason-lspconfig.nvim",
		},
	},

	{
		"mbbill/undotree",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<leader>ut", "<cmd>UndotreeToggle<CR>", desc = "Undotree toggle" },
		},
	},
	{
		"Aasim-A/scrollEOF.nvim",
		event = { "CursorMoved", "WinScrolled" },
		opts = {},
	},
	{
		"ojroques/nvim-bufdel",
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
