return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- "williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local M = {}
		local map = vim.keymap.set

		local diagnostic_goto = function(next, serverity)
			return function()
				vim.diagnostic.jump({
					count = (next and 1 or -1) * vim.v.count1,
					severity = serverity and vim.diagnostic.severity[serverity] or nil,
					float = true,
				})
			end
		end

		-- export on_attach & capabilities
		M.on_attach = function(_, bufnr)
			local function opts(desc)
				return { buffer = bufnr, desc = "LSP " .. desc }
			end

			map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
			map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
			map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
			map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

			map("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts("List workspace folders"))

			map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
			map("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename"))
			map("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
			map("n", "<leader>cd", vim.diagnostic.open_float, opts("Line Diagnostic"))

			map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
			map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Next Error" })

			map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
			map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Next Warning" })
		end

		M.on_init = function(client, _)
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

		M.capabilities = require("blink.cmp").get_lsp_capabilities()
		M.capabilities.textDocument.completion.completionItem = {
			documentationFormat = { "markdown", "plaintext" },
			snippetSupport = true,
			preselectSupport = true,
			insertReplaceSupport = true,
			labelDetailsSupport = true,
			deprecatedSupport = true,
			commitCharactersSupport = true,
			tagSupport = { valueSet = { 1 } },
			resolveSupport = {
				properties = {
					"documentation",
					"detail",
					"additionalTextEdits",
				},
			},
		}

		M.defaults = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					M.on_attach(_, args.buf)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true)
					end
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

			vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init })
		end

		M.defaults()

		local servers = {
			-- lua lsp
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostic = {
							globals = { "love" },
						},
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

			-- golang lsp
			gopls = {
				settings = {
					gopls = {
						gofumpt = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			},

			-- emmet lsp
			emmet_language_server = {
				filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"pug",
					"typescriptreact",
				},
				init_options = {
					---@type table<string, string>
					includeLanguages = {},
					--- @type string[]
					excludeLanguages = {},
					--- @type string[]
					extensionsPath = {},
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
					preferences = {},
					--- @type boolean Defaults to `true`
					showAbbreviationSuggestions = true,
					--- @type "always" | "never" Defaults to `"always"`
					showExpandedAbbreviation = "always",
					provideCloseTag = false,
					--- @type boolean Defaults to `false`
					showSuggestionsAsSnippets = false,
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
					syntaxProfiles = {
						html = {
							inline_break = 1,
						},
					},
					--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
					variables = {},
				},
			},

			-- bash lsp
			bashls = {},
		}

		require("mason-tool-installer").setup({
			ensure_installed = vim.tbl_keys(servers or {}),
			run_on_start = true,
		})

		for name, opts in pairs(servers) do
			vim.lsp.config(name, opts)
			vim.lsp.enable(name)
		end
	end,
}
