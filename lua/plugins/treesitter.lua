return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    opts = {

        ensure_installed = {
            "lua",
            "luadoc",
            "printf",
            "vim",
            "vimdoc",
            "html",
            "css",
            "rust",
            "ocaml",
            "slint",
        }
    },
    config = function(_, opts)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "<filetype>" },
            callback = function()
                vim.treesitter.start()
            end,
        })
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        require("nvim-treesitter").install(opts.ensure_installed)
    end
}
