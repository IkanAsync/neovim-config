local map = vim.keymap.set
map("i", "jk", "<ESC>", { silent = true })
map("n", ";", ":")
map("n", "<leader>e", ":Oil --preview<CR>", { silent = true, noremap = true, desc = "Oil" })

map("n", "<S-l>", ":bnext<CR>", { silent = true })
map("n", "<S-h>", ":bprevious<CR>", { silent = true })

map("n", "<leader>ww", ":wa<CR>", { silent = true, desc = "Save all" })
map("n", "<leader>qq", ":qa<CR>", { silent = true, desc = "Quit" })
map("n", "<leader>bd", ":BufDel<CR>", { silent = true, noremap = true, desc = "Delete buffer" })
map("n", "<leader>bo", ":BufDelOthers<CR>", { silent = true, noremap = true, desc = "Delete buffer" })
map("n", "<leader>lr", ":LspRestart<CR>", { silent = true, noremap = true, desc = "Lsp restart" })
map("n", "gl", "$", { silent = true })
map("n", "gh", "_", { silent = true })
map("n", "<leader>th", ":Themery<CR>", { silent = true, noremap = true, desc = "Theme picker" })

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- terminal
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	direction = "float",
	float_opts = {
		border = "rounded",
		width = 180,
		height = 50,
		winblend = 3,
	},
})

local gemini = Terminal:new({
	cmd = "gemini",
	hidden = true,
	direction = "horizontal",
	float_opts = {
		border = "rounded",
		width = 180,
		height = 50,
		winblend = 3,
	},
})

local btop = Terminal:new({
	cmd = "btop",
	hidden = true,
	direction = "float",
	float_opts = {
		border = "rounded",
		width = 180,
		height = 50,
		winblend = 3,
	},
})

function gemini_toggle()
	gemini:toggle()
end

function btop_toggle()
	btop:toggle()
end

function lazygit_toggle()
	lazygit:toggle()
end

map({ "n", "i", "t" }, "<C-g>", "<cmd>lua gemini_toggle()<CR>", { desc = "gemini ai", silent = true, noremap = true })
map("n", "<leader>tl", "<cmd>lua lazygit_toggle()<CR>", { noremap = true, silent = true, desc = "lazygit" })
map("n", "<leader>tb", "<cmd>lua btop_toggle()<CR>", { noremap = true, silent = true, desc = "btop" })
