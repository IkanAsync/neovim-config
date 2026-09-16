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
        },
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
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local map = vim.keymap.set
                    local function lsp_opts(desc)
                        return { buffer = bufnr, desc = "LSP " .. desc }
                    end

                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true)
                    end

                    map("n", "gD", vim.lsp.buf.declaration, lsp_opts("Go to declaration"))
                    map("n", "gd", vim.lsp.buf.definition, lsp_opts("Go to definition"))
                    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, lsp_opts("Add workspace folder"))
                    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, lsp_opts("Remove workspace folder"))

                    map("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, lsp_opts("List workspace folders"))

                    map("n", "<leader>cr", vim.lsp.buf.rename, lsp_opts("Rename"))
                    map("n", "<leader>cd", vim.diagnostic.open_float, lsp_opts("Diagnostic"))
                    map("n", "<leader>ca", vim.lsp.buf.code_action, lsp_opts("Code action"))
                end,
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

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            capabilities.textDocument.completion.completionItem.labelDetailsSupport = true

            local on_init = function(client, _)
                if vim.fn.has("nvim-0.11") ~= 1 then
                    if client.supports_method("textDocument/semanticTokens") then
                        client.server_capabilities.semanticTokensProvider = nil
                    end
                else
                    if client:supports_method("textDocument/semanticTokens") then
                        client.server_capabilities.semanticTokensProvider = nil
                    end
                end
            end

            vim.lsp.config("*", {
                capabilities = capabilities,
                on_init = on_init,
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
                    filetypes = {
                        'ocaml',
                        'ocaml.interface',
                        'ocaml.menhir',
                        'ocaml.ocamllex',
                        'dune',
                        'reason'
                    },
                    root_markers = {
                        { 'dune-project', 'dune-workspace' },
                        { "*.opam",       "esy.json",      "package.json" },
                        '.git'
                    },
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
                },
            }

            vim.lsp.enable("slint-lsp")

            for name, opts in pairs(servers) do
                if not opts.root_dir then
                    opts.root_dir = vim.fs.root(0, { ".git", "go.mod", "package.json", "stack.yaml", "cabal.project" })
                end
                opts.capabilities = vim.tbl_deep_extend("force", capabilities, opts.capabilities or {})
                vim.lsp.config(name, opts)
                vim.lsp.enable(name)
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = opts.filetypes,
                    callback = function()
                        vim.lsp.enable(name)
                    end,
                })
            end
            return {}
        end,
    },
}
