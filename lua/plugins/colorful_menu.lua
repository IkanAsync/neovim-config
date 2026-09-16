return {
    "xzbdmw/colorful-menu.nvim",
    config = function()
        require("colorful-menu").setup({
            ls = {
                lua_ls = {
                    arguments_hl = "@comment",
                },
                gopls = {
                    align_type_to_right = true,
                    add_colon_before_type = false,
                    preserve_type_when_truncate = true,
                },
                ["rust-analyzer"] = {
                    extra_info_hl = "@comment",
                    align_type_to_right = true,
                    preserve_type_when_truncate = true,
                },
                zls = {
                    align_type_to_right = true,
                },
                basedpyright = {
                    extra_info_hl = "@comment",
                },
                pylsp = {
                    extra_info_hl = "@comment",
                    arguments_hl = "@comment",
                },
                fallback = true,
                fallback_extra_info_hl = "@comment",
            },
            fallback_highlight = "@variable",
            max_width = 60,
        })
    end,
}
