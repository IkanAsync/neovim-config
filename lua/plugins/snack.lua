return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@diagnostic disable-next-line: undefined-doc-name
	---@type snacks.Config
	opts = {
		bigfile = { enabled = false },
		dashboard = {
			enabled = true,
			sections = {
				{
					section = "terminal",
					align = "center",
					height = 26,
					width = 72,
					padding = 1,
					cmd = "lolcat --seed=40 ~/.config/nvim/static/frieren.cat",
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
		indent = { enabled = false },
		input = { enabled = false },
		picker = { enabled = false },
		notifier = { enabled = false },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
}
