local map = vim.keymap.set

map("i", "jk", "<ESC>")
map({ "n", "v" }, ";", ":")
map("n", "<leader>qq", ":qa<CR>", { silent = true, noremap = true })
map("n", "<leader>ww", ":wa<CR>", { silent = true, noremap = true })
map("n", "<esc>", ":noh<CR>", { silent = true, noremap = true })


map("n", "<S-l>", ":bnext<CR>", { silent = true })
map("n", "<S-h>", ":bprevious<CR>", { silent = true })
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("i", "<M-Space>", "~")

map({ "n", "x", "o" }, "s", function()
    require("flash").jump()
end, { noremap = true, silent = true, nowait = true, desc = "Flash" })

local miniharp = require("miniharp")

map("n", "<leader>m", miniharp.toggle_file, { desc = "miniharp: toggle file mark" })
map("n", "<C-n>", miniharp.next, { desc = "miniharp: next file mark" })
map("n", "<C-p>", miniharp.prev, { desc = "miniharp: prev file mark" })
map("n", "<leader><leader>", miniharp.show_list, { desc = "miniharp: toggle marks list" })
map("n", "<leader>L", miniharp.enter_list, { desc = "miniharp: enter marks list" })

map("n", "<leader>1", function()
    miniharp.go_to(1)
end, { desc = "miniharp: go to mark 1" })
map("n", "<leader>2", function()
    miniharp.go_to(2)
end, { desc = "miniharp: go to mark 2" })
map("n", "<leader>3", function()
    miniharp.go_to(3)
end, { desc = "miniharp: go to mark 3" })
map("n", "<leader>4", function()
    miniharp.go_to(4)
end, { desc = "miniharp: go to mark 4" })

local enable = false

map("n", "<leader>rr", function()
    if not enable then
        vim.cmd("silent! RustGpuEnable")
    else
        vim.cmd("silent! RustGpuDisable")
    end
    enable = not enable
end, { desc = "Toggle Gpu" })

local Terminal = require("toggleterm.terminal").Terminal

local run = Terminal:new {
    cmd = "make run",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "rounded",
        width = 180,
        height = 50,
        winblend = 3,
    },
}
local lazygit = Terminal:new {
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "rounded",
        width = 180,
        height = 50,
        winblend = 3,
    },
}

local function lazygit_toggle()
    lazygit:toggle()
end
local function run_toggle()
    run:toggle()
end

map("n", "<leader>cc", function()
    run_toggle()
end, { desc = "Make run", silent = true, noremap = true })
