-- merubah warna number line
vim.api.nvim_set_hl(0, "LineNr", { fg = "#ff8800", bg = "NONE" }) -- Ganti warna dengan kode yang diinginkan

vim.opt.list = false
vim.opt.expandtab = true -- Mengubah tab menjadi spasi
vim.opt.shiftwidth = 4 -- Mengatur jumlah spasi per indentasi
vim.opt.tabstop = 4 -- Menentukan ukuran tab sebagai 4 spasi
vim.opt.listchars:append "space:·" -- Menampilkan spasi sebagai titik (·)
vim.opt.listchars:append "tab:···" -- Menampilkan tab sebagai panah dengan titik

vim.cmd [[
  highlight Directory guifg=#D4D4D4   
  highlight NvimTreeFolderName guifg=#D4D4D4
]]

vim.cmd [[
  highlight ListCharTab guifg=#89b4fa
  highlight ListCharTrail guifg=#f38ba8
  highlight ListCharNbsp guifg=#a6e3a1
]]

-- Auto-center search results
vim.cmd [[
  nnoremap n nzzzv
  nnoremap N Nzzzv
  nnoremap * *zzzv
  nnoremap # #zzzv
  nnoremap g* g*zzzv
  nnoremap g# g#zzzv
]]

vim.opt.number = false -- Mematikan nomor baris biasa
vim.opt.relativenumber = true -- Mengaktifkan nomor baris relatif

vim.lsp.inlay_hint.enable(true) -- Aktifkan inlay hint secara global

-- membuat layar selalu berada di tengah-tengah
vim.api.nvim_create_autocmd({ "CursorMoved" }, {
  pattern = "*",
  command = "normal! zz",
})

-- Set transparansi untuk lualine
vim.cmd [[
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE
]]

-- Transparansi untuk input window umum
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

-- Ubah bentuk kursor sesuai mode
vim.opt.guicursor = "n-v-c:block,i:ver25,r-cr:hor20,o:hor50"
