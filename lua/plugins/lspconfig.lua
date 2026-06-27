return {
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        opts = {
            PATH = "skip",
            ui = {
                icons = {
                    package_pending = " ",
                    package_installed = " ",
                    package_uninstalled = " ",
                },
            },
            max_concurrent_installers = 10,
        }
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        -- dependencies = {
        --     { "j-hui/fidget.nvim", opts = {} },
        -- },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
                callback = function(ev)
                    local opts = function(desc)
                        return { buffer = ev.buf, desc = desc }
                    end

                    local map = function(mode, lhs, rhs, options)
                        vim.keymap.set(mode, lhs, rhs, options)
                    end

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true)
                    end



                    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
                    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
                    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
                    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

                    map("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts "List workspace folders")

                    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
                    map("n", "<leader>cr", vim.lsp.buf.rename, opts "Rename")
                    map("n", "<leader>cd", vim.diagnostic.open_float, opts "Diagnostic")
                    map("n", "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
                end
            })

            vim.diagnostic.config({
                severity_sort = true,
                float = { border = "rounded", source = "if_many" },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                } or {},
                virtual_text = {
                    source = "if_many",
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            })

            local servers = {
                slint_lsp = {
                    filetypes = { "slint" },
                    cmd = { "slint-lsp" },
                    root_markers = { ".git" },
                },
                lua_ls = {
                    filetypes = { "lua" },
                    root_markers = { ".git" },
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            workspace = {
                                library = {
                                    vim.fn.expand("$VIMRUNTIME/lua"),
                                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                                    "${3rd}/luv/library",
                                },
                            },
                        },
                    },
                },
                ocamllsp = {
                    cmd = { "/home/ikanasync/.opam/default/bin/ocamllsp" },
                    filetypes = { "ml", "ocaml", "ocaml.interface", "ocaml.menhir", "ocaml.preprocess" },
                    root_markers = { ".git", "stack.yaml", "cabal.project" },
                    settings = {
                        inlayHints = {
                            enable = true,
                            hintPatternVariables = true,
                            hintLetBindings = true,
                            hintFunctionParams = true,
                        },
                    },
                },
                pyright = {
                    filetypes = { "python" },
                    root_markers = { ".git", "pyproject.toml" },
                }
            }

            vim.lsp.enable("slint-lsp")

            for name, opts in pairs(servers) do
                if not opts.root_dir then
                    opts.root_dir = vim.fs.root(0, { ".git", "go.mod", "package.json", "stack.yaml", "cabal.project" })
                end
                vim.lsp.config(name, opts)
                vim.lsp.enable(name)
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = opts.filetypes,
                    callback = function()
                        vim.lsp.enable(name)
                    end,
                })
            end
        end
    },
}
