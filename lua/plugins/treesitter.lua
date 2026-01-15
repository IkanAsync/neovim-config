return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"lua",
			"luadoc",
			"printf",
			"vim",
			"vimdoc",
			"go",
			"gowork",
			"gosum",
			"html",
			"css",
		},

		highlight = {
			enable = true,
			use_languagetree = true,
			custom_captures = {},
		},
		auto_install = true,

		indent = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
