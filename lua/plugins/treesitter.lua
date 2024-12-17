 if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "html",
      "css",
      -- add more arguments for adding more treesitter parsers
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    -- Enable experimental feature for macro highlighting
    require("nvim-treesitter").define_modules {
      rust_macro_html = {
        module_path = "nvim-treesitter-html-in-rust-macros",
        enable = true,
      },
    }
  end,
}
