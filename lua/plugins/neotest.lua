return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    { "nvim-neotest/neotest-python" },
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "rcasia/neotest-java",
    "fredrikaverpil/neotest-golang",
    "nvim-neotest/neotest-go",
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-python" {
          dap = { justMyCode = false },
          args = { "--log-cli-level", "DEBUG" },
          python = ".venv/bin/python",
          runner = "pytest",
        },
        require "rustaceanvim.neotest"(),
        require "neotest-go" {
          experimental = {
            test_table = true,
          },
          args = { "-count=1", "-timeout=60s" },
        },
      },
    }
  end,
}
