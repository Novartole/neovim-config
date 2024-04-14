return {
	"mrcjkb/rustaceanvim",
	version = "^4",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"lvimuser/lsp-inlayhints.nvim",
		"mfussenegger/nvim-dap",
	},
	ft = { "rust" },
	opts = {
		tools = {
			hover_actions = {
				replace_builtin_hover = false, -- keep build-in style
			},
			float_win_config = {
				border = {
					{ "╭", "FloatBorder" },
					{ " ", "FloatBorder" },
					{ "╮", "FloatBorder" },
					{ " ", "FloatBorder" },
					{ "╯", "FloatBorder" },
					{ " ", "FloatBorder" },
					{ "╰", "FloatBorder" },
					{ " ", "FloatBorder" },
				},
				-- same as for hover defined in noice
				--
				max_height = 20,
				max_width = 120,

				offset_x = 1, -- a trick to align floating window

				padding_x = 2,
			},
		},
		server = {
			on_attach = function(client, bufnr)
				require("lsp-inlayhints").on_attach(client, bufnr) -- turn on inlayhints

				local keymap = vim.keymap
				local opts = {
					buffer = bufnr,
					silent = true,
				}

				keymap.set(
					"n",
					"gC",
					":RustLsp openCargo<CR>",
					vim.tbl_extend("force", opts, { desc = "Open Cargo.toml" })
				)
				keymap.set(
					"n",
					"gM",
					":RustLsp expandMacro<CR>",
					vim.tbl_extend("force", opts, { desc = "Expand macro" })
				)
				keymap.set(
					"n",
					"ge",
					":RustLsp explainError<CR>",
					vim.tbl_extend("force", opts, { desc = "Explain error" })
				)
				keymap.set(
					"n",
					"gdf",
					":RustLsp renderDiagnostic<CR>",
					vim.tbl_extend("force", opts, { desc = "Show full error" })
				)
			end,
		},
		dap = {
			autoload_configurations = true,
		},
	},
	init = function()
		local open_floating_preview = vim.lsp.util.open_floating_preview
		vim.lsp.util.open_floating_preview = function(contents, syntax, _opts)
			-- force focusing in certain cases
			--
			if _opts and vim.tbl_contains({ "rustc-explain-error", "ra-render-diagnostic" }, _opts.focus_id) then
				-- add horizontal padding, but skip action section
				-- (such kind of events always have the section)
				--
				local padding = string.rep(" ", _opts.padding_x or 0)
				if string.len(padding) > 0 then
					for index = 3, #contents do
						contents[index] = string.format("%s%s%s", padding, contents[index], padding)
					end
				end

				local bufnr, winnr = open_floating_preview(contents, syntax, _opts)

				vim.api.nvim_set_current_win(winnr)

				return bufnr, winnr
			end

			return open_floating_preview(contents, syntax, _opts)
		end
	end,
	config = function(_, opts)
		vim.g.rustaceanvim = opts
	end,
}
