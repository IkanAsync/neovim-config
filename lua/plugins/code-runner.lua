return {
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup {
        filetype = {
          java = {
            "cd $dir &&",
            "javac $filename &&",
            "java $fileNameWithoutExt",
          },
          go = {
            "go run .",
          },
          rust = {
            "cargo run .",
          },
        },
      }
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rc",
        ":RunCode<CR>",
        { noremap = true, silent = true, desc = "Running Code" }
      )
    end,
  },
}
