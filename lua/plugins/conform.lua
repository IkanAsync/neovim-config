local M = {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			css = { "prettier" },
			html = { "prettier" },
			go = { "goimports" },
			python = { "black" },
			kdl = { "kdlfmt" },
			sh = { "shfmt" },
			rust = { "rustfmt" },
		},

		formatters = {
			rustfmt = {
				command = "rustfmt", -- dari rustup
				stdin = true,
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = false,
		},
	},
}

-- local mason_tools = vim.tbl_flatten(vim.tbl_values(M.opts.formatters_by_ft))

local mason_tools = vim.tbl_filter(function(tool)
	return tool ~= "rustfmt"
end, vim.tbl_flatten(vim.tbl_values(M.opts.formatters_by_ft)))

require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = mason_tools,
	run_on_start = true,
})

return M
