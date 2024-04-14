return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
		"saecki/crates.nvim",
	},
	opts = {
		servers = {
			["clangd"] = {},
			["tsserver"] = {
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
				on_attach = function(client, bufnr)
					require("lsp-inlayhints").on_attach(client, bufnr)
				end,
			},
			["pyright"] = {},
			["dockerls"] = {},
			["docker_compose_language_service"] = {
				filetypes = { "yml", "yaml" },
				autostart = false,
			},
			["lua_ls"] = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- make the language server recognize "vim" global
						},
					},
				},
			},
			["taplo"] = {
				on_attach = function(_, bufnr)
					if vim.fn.expand("%:t") == "Cargo.toml" then
						local crates = require("crates")
						local lsp = vim.lsp
						local keymap = vim.keymap
						local opts = { buffer = bufnr }

						keymap.set("n", "K", function()
							if crates.popup_available() then
								crates.show_popup()
							else
								lsp.buf.hover()
							end
						end, vim.tbl_extend("force", opts, { desc = "Show crate preview" }))

						keymap.set(
							"n",
							"<leader>cH",
							crates.open_homepage,
							vim.tbl_extend("force", opts, { desc = "Open crate homepage" })
						)
						keymap.set(
							"n",
							"<leader>cR",
							crates.open_repository,
							vim.tbl_extend("force", opts, { desc = "Open crate repository" })
						)
						keymap.set(
							"n",
							"<leader>cD",
							crates.open_documentation,
							vim.tbl_extend("force", opts, { desc = "Open crate documentation" })
						)
						keymap.set(
							"n",
							"<leader>cC",
							crates.open_crates_io,
							vim.tbl_extend("force", opts, { desc = "Open crate.io" })
						)

						keymap.set(
							"n",
							"<leader>cv",
							crates.show_versions_popup,
							vim.tbl_extend("force", opts, { desc = "Show crate version" })
						)
						keymap.set(
							"n",
							"<leader>cf",
							crates.show_features_popup,
							vim.tbl_extend("force", opts, { desc = "Show crate features" })
						)
						keymap.set(
							"n",
							"<leader>cd",
							crates.show_dependencies_popup,
							vim.tbl_extend("force", opts, { desc = "Show crate dependencies" })
						)
					end
				end,
			},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities() -- add additional capabilities supported by nvim-cmp

		for server, _opts in pairs(opts.servers) do
			lspconfig[server].setup(vim.tbl_deep_extend("error", {
				capabilities = capabilities,
			}, _opts))

			if server == "docker_compose_language_service" then
				vim.api.nvim_create_autocmd("BufRead", {
					group = vim.api.nvim_create_augroup("LspDockerCompose", {}),
					pattern = "*docker-compose*.y[a]\\\\\\{0,1\\}ml",
					callback = function()
						local buf = vim.api.nvim_get_current_buf()
						local clients = vim.lsp.get_active_clients({ bufnr = buf })
						if vim.tbl_isempty(clients) then
							vim.cmd("LspStart")
						end
					end,
				})
			end
		end

		-- use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local cmd = vim.cmd
				local diagnostic = vim.diagnostic
				local lsp = vim.lsp
				local keymap = vim.keymap
				local _opts = { buffer = ev.buf }

				keymap.set(
					"n",
					"gr",
					"<cmd>Telescope lsp_references<CR>",
					vim.tbl_extend("force", _opts, { desc = "Show definition, references" })
				)
				keymap.set(
					"n",
					"gD",
					lsp.buf.declaration,
					vim.tbl_extend("force", _opts, { desc = "Go to declaration" })
				)
				keymap.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					vim.tbl_extend("force", _opts, { desc = "Show lsp implementations" })
				)
				keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					vim.tbl_extend("force", _opts, { desc = "Show lsp type definitions" })
				)
				keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					vim.tbl_extend("force", _opts, { desc = "Show lsp definitions" })
				)

				keymap.set(
					"n",
					"<leader>a",
					lsp.buf.code_action,
					vim.tbl_extend(
						"force",
						_opts,
						{ desc = "See available code actions, in visual mode will apply to selection" }
					)
				)
				keymap.set("n", "<leader>rn", lsp.buf.rename, vim.tbl_extend("force", _opts, { desc = "Smart rename" }))
				keymap.set(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					vim.tbl_extend("force", _opts, { desc = "Show  diagnostics for file" })
				)
				keymap.set(
					"n",
					"<leader>d",
					diagnostic.open_float,
					vim.tbl_extend("force", _opts, { desc = "Show diagnostics for line" })
				)
				keymap.set(
					"n",
					"[d",
					diagnostic.goto_prev,
					vim.tbl_extend("force", _opts, { desc = "Jump to previous diagnostic in buffer" })
				)
				keymap.set(
					"n",
					"]d",
					diagnostic.goto_next,
					vim.tbl_extend("force", _opts, { desc = "Jump to next diagnostic in buffer" })
				)
				keymap.set(
					"n",
					"K",
					lsp.buf.hover,
					vim.tbl_extend("force", _opts, { desc = "Show documentation for what is under cursor" })
				)
				keymap.set(
					"n",
					"<leader>lsp",
					cmd.LspRestart,
					vim.tbl_extend("force", _opts, { desc = "Mapping to restart lsp if necessary" })
				)
			end,
		})

		-- change the Diagnostic symbols in the sign column (gutter)
		for type, icon in pairs({ Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
