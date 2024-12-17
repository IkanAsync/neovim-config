vim.api.nvim_set_keymap(
  "n",
  "<leader>ta",
  ":lua os.execute('alacritty &')<CR>",
  { noremap = true, silent = true, desc = "alacritty" }
)

local map = vim.api.nvim_set_keymap
-- keymap escape
map("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })

require("notify").setup {
  background_colour = "#000000",
}

local neotest = require "neotest"

-- Keymap untuk menjalankan tes di bawah kursor
vim.keymap.set(
  "n",
  "<leader>tr",
  function() neotest.run.run() end,
  { noremap = true, silent = true, desc = "Run nearest test" }
)

-- keymap untuk run test golang
vim.keymap.set("n", "<leader>tg", function()
  neotest.run.run(nil, function() neotest.output.open { enter = true } end)
end, { noremap = true, silent = true, desc = "Run nearest test golang" })

-- Keymap untuk menjalankan semua tes di file saat ini
vim.keymap.set(
  "n",
  "<leader>tf",
  function() neotest.run.run(vim.fn.expand "%") end,
  { noremap = true, silent = true, desc = "Run all tests in current file" }
)

-- Keymap untuk membuka jendela hasil tes
vim.keymap.set(
  "n",
  "<leader>ts",
  function() neotest.summary.toggle() end,
  { noremap = true, silent = true, desc = "Toggle test summary" }
)

vim.keymap.set(
  "n",
  "<leader>tw",
  function() neotest.watch.toggle() end,
  { noremap = true, silent = true, desc = "Toggle test watch" }
)

-- keymap untuk menghentikan test
vim.keymap.set(
  "n",
  "<leader>tS",
  function() neotest.run.stop() end,
  { noremap = true, silent = true, desc = "Stop test" }
)

-- Keymap untuk membuka jendela output hasil tes
vim.keymap.set(
  "n",
  "<leader>to",
  function() neotest.output.open { enter = true } end,
  { noremap = true, silent = true, desc = "Show test output" }
)

--keymap untuk membuka terminal output
vim.keymap.set(
  "n",
  "<leader>tO",
  function() neotest.output_panel.open() end,
  { noremap = true, silent = true, desc = "membuka output test di terminal" }
)
-- ===============================================================================

-- Key mapping untuk auto-import
vim.api.nvim_set_keymap(
  "n",
  "<leader>ri",
  "<cmd>lua vim.lsp.buf.code_action()<CR>",
  { noremap = true, silent = true, desc = "Auto import rust" }
)

-- keymap untuk membuka Database UI
map("n", "<leader>db", ":DBUIToggle<CR>", { desc = "Toggle Database UI" })

-- keymap lain untuk akses cepat (opsional)
map("n", "<leader>dq", ":DBUIFindBuffer<CR>", { desc = "Find DB Buffer" })

-- Keymap untuk membuka terminal dan menjalankan 'cargo run'
map("n", "<leader>rr", ":split | terminal cargo run<CR>", { noremap = true, silent = true, desc = "running rust" })

-- keymap untuk membuka dan menjalankan 'go run .'
map("n", "<leader>gr", ":split | terminal go run .<CR>", { noremap = true, silent = true, desc = "running go" })

-- Keymap untuk menjalankan file Python
vim.api.nvim_set_keymap("n", "<leader>pr", ":vsplit | term python3 %<CR>", { noremap = true, silent = true })

--Keymap untuk menjalnkan swagger
vim.api.nvim_set_keymap(
  "n",
  "<leader>sr",
  ":SwaggerPreview<CR>",
  { noremap = true, silent = true, desc = "running swagger" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>ss",
  ":SwaggerPreviewStop<CR>",
  { noremap = true, silent = true, desc = "stop swagger" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>st",
  ":SwaggerPreviewToggle<CR>",
  { noremap = true, silent = true, desc = "toggle swagger" }
)
