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

vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end
})

local function toggle_gpu_version(enable)
    local current_config = vim.g.rustaceanvim
    local config = {}

    if type(current_config) == "function" then
        config = current_config()
    elseif type(current_config) == "table" then
        config = current_config
    end

    config.server = config.server or {}
    config.server.default_settings = config.server.default_settings or {}
    config.server.default_settings["rust-analyzer"] = config.server.default_settings["rust-analyzer"] or {}

    local features_list = enable and { "versi-gpu" } or {}

    config.server.default_settings["rust-analyzer"].cargo = {
        features = features_list,
    }
    config.server.default_settings["rust-analyzer"].check = {
        features = features_list,
        extraArgs = { "-j", "2" },
    }

    vim.g.rustaceanvim = config

    local status = enable and "aktif" or "non-aktif"
    vim.notify("versi-gpu " .. status, vim.log.levels.INFO, { title = "Rustaceanvim" })

    vim.cmd("LspRestart rust_analyzer")
end

vim.api.nvim_create_user_command("RustGpuEnable", function()
    toggle_gpu_version(true)
end, {})

vim.api.nvim_create_user_command("RustGpuDisable", function()
    toggle_gpu_version(false)
end, {})

-- vim.g.rustaceanvim = {
--     server = {
--         default_settings = {
--             ['rust-analyzer'] = {
--                 cargo = {
--                     target = "x86_64-linux-android",
--                 },
--             },
--         },
--     },
-- }
