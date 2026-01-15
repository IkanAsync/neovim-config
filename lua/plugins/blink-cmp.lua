return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "select_and_accept", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		signature = {
			enabled = true,
			trigger = {
				show_on_insert = true,
				show_on_insert_on_trigger_character = true,
			},
		},
		completion = {
			documentation = { auto_show = false },
			ghost_text = {
				enabled = false,
			},
			trigger = {
				show_on_accept_on_trigger_character = false,
				show_on_insert_on_trigger_character = false,
			},
		},
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
