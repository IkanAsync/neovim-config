return{
    "stevearc/conform.nvim",
    opts ={
        formatters_by_ft = {
            lua = { "stylua" },
            css = { "prettier" },
            html = { "prettier" },
            python = { "black" },
            sh = { "shfmt" },
            rust = { "rustfmt" },
            tcss = { "prettier" },
            ocaml = { "ocamlformat" },
            haskell = { "ormolu" }, -- atau "fourmolu"
            slint = { "slint_lsp" },
            go = { "goimports", "gofumpt" },
        },

        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    }
}
