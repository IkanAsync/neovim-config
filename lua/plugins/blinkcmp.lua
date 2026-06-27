return {
    'saghen/blink.cmp',
    dependencies = {
        'saghen/blink.lib',

        'rafamadriz/friendly-snippets',
    },
    build = function()
        require('blink.cmp').build():pwait()
    end,



    opts = {
        completion = {
            documentation = { auto_show = false },

            ghost_text = { enabled = false },
            list = {
                selection = {
                    auto_insert = false,
                },
            },
        },

        keymap = {
            ["<CR>"] = { "accept", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
        },
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

        fuzzy = { implementation = "rust" }
    },
}
