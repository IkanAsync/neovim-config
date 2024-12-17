return {
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup {
        cmdline = {
          view = "cmdline_popup",
        },
        popupmenu = {
          enabled = true,
        },
        views = {
          cmdline_popup = {
            position = {
              row = "50%",
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
        },
        lsp = {
          signature = {
            enabled = false,
          },
          hover = {
            enabled = false,
          },
        },
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
