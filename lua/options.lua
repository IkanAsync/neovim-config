local opt = vim.opt
local o = vim.o
local g = vim.g

vim.api.nvim_set_hl(0, "LspInlayHint", { bg = "none", fg = "#585b70" })
o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "both"

o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.number = true
o.numberwidth = 2
o.ruler = false
o.relativenumber = true

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 300
o.undofile = true

o.updatetime = 250

opt.whichwrap:append("<>[]hl")

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

opt.guicursor = { "n-v-c-i:block" }
opt.scrolloff = 10
opt.termguicolors = true
opt.list = true
opt.listchars = { tab = "▸ ", trail = "·", extends = ">", precedes = "<", space = "·" }


vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#4b5263", bg = "NONE" })

vim.opt.fillchars:append({
    foldopen = "▼",
    foldclose = "▶",
    foldsep = "│",
    fold = " ",
})

vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#88c0d0", bg = "NONE" })

_G.custom_fold_text = function()
    local fs = vim.v.foldstart
    local fe = vim.v.foldend

    local lines = vim.api.nvim_buf_get_lines(0, fs - 1, fs + 1, false)
    local first_line = lines[1] or ""
    local second_line = lines[2] or ""

    local fold_lines = fe - fs + 1
    local suffix = string.format("  󰁂 %d lines folded ", fold_lines)

    local function clean_comment(text)
        return vim.trim(text:gsub("//", ""):gsub("#", ""):gsub("%-%-", ""):gsub("/%*", ""):gsub("%*/", ""))
    end

    local comment_pattern = "^%s*(%s*//|%s*%-%-|%s*#|%s*/%*)"

    if first_line:match(comment_pattern) then
        return "  " .. clean_comment(first_line) .. suffix
    elseif second_line:match(comment_pattern) then
        return "  " .. clean_comment(second_line) .. " (" .. vim.trim(first_line) .. ")" .. suffix
    end

    return "  " .. vim.trim(first_line) .. suffix
end

vim.opt.foldtext = "v:lua.custom_fold_text()"
vim.opt.fillchars:append({ fold = " " })
