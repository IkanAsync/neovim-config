vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

local view_group = vim.api.nvim_create_augroup("auto_view", { clear = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
    group = view_group,
    pattern = "?*",
    callback = function()
        if vim.bo.buftype ~= "" or vim.fn.expand("%") == "" then
            return
        end
        vim.cmd.mkview()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "?*",
    callback = function()
        vim.schedule(function()
            vim.cmd "silent! loadview"
        end)
    end,
})

local function toggle_gpu_version(enable)
    -- Ambil tabel saat ini atau buat tabel baru jika nil
    local config = vim.g.rustaceanvim or {}

    -- Pastikan struktur tabel tersedia di level lokal
    config.server = config.server or {}
    config.server.default_settings = config.server.default_settings or {}
    config.server.default_settings["rust-analyzer"] = config.server.default_settings["rust-analyzer"] or {}

    -- Tentukan list fitur
    local features_list = enable and { "versi-gpu" } or {}

    -- Update nilai pada tabel lokal
    config.server.default_settings["rust-analyzer"].cargo = {
        features = features_list,
    }
    config.server.default_settings["rust-analyzer"].check = {
        features = features_list,
        extraArgs = { "-j", "2" },
    }

    -- Terapkan kembali ke global variable (PENTING: Harus assign ulang seluruh tabel)
    vim.g.rustaceanvim = config

    -- Notifikasi
    local status = enable and "aktif" or "non-aktif"
    vim.notify("versi-gpu " .. status, vim.log.levels.INFO, { title = "Rustaceanvim" })

    -- Restart LSP
    vim.cmd("LspRestart rust_analyzer")
end

-- Command tetap sama
vim.api.nvim_create_user_command("RustGpuEnable", function()
    toggle_gpu_version(true)
end, {})

vim.api.nvim_create_user_command("RustGpuDisable", function()
    toggle_gpu_version(false)
end, {})
