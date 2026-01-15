return {
	{
		"catppuccin/nvim",
		event = "VeryLazy",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				term_colors = true,
			})
		end,
	},
	{
		"gbprod/nord.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {},
	},
	{
		"folke/tokyonight.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {},
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = { "tokyonight", "nord", "catppuccin" },
				livePreview = true,
			})
		end,
	},
}
