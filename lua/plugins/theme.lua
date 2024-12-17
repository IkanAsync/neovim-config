return {
  -- {
  --   "catppuccin/nvim",
  --   as = "catppuccin",
  --   config = function()
  --     require("catppuccin").setup {
  --       transparent_background = true,
  --     }
  --     vim.cmd "colorscheme catppuccin"
  --   end,
  -- },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup {
        style = "dark", -- Pilih 'dark' atau 'light' sesuai kebutuhan
        transparent = true, -- Untuk latar belakang transparan
      }
      vim.cmd "colorscheme vscode"
    end,
  },
}
