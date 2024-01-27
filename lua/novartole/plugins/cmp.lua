return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		-- snippets
		--
		"saadparwaiz1/cmp_luasnip", -- luasnip completion source, name = "luasnip"

		-- buffer / Vim-builtin functionality
		--
		"hrsh7th/cmp-buffer", -- source for text in buffer, name = "buffer"
		"amarakon/nvim-cmp-buffer-lines", -- source for all the lines in the current buffer, name = "buffer-lines"

		-- LSP
		--
		"hrsh7th/cmp-nvim-lsp", -- source for neovim's built-in language server client, name = "nvim_lsp"
		-- source for displaying function signatures with the current parameter emphasized,
		-- name = "nvim_lsp_signature_help"
		"hrsh7th/cmp-nvim-lsp-signature-help",

		-- filesystem paths
		--
		"FelipeLema/cmp-async-path", -- source for filesystem paths with async processing, name = "async_path"

		-- commmand line
		--
		"hrsh7th/cmp-cmdline", -- source for vim's cmdline, name = "cmdline"
		"dmitmel/cmp-cmdline-history", -- source for from command-line histories, name = "cmdline_history"

		-- dependencies
		--
		-- "Saecki/crates.nvim", -- source for Cargo.toml (rust), name = "crates"

		-- miscellaneous
		--
		"hrsh7th/cmp-nvim-lua", -- source for neovim Lua API, name = "nvim_lua"

		-- engines
		--
		"L3MON4D3/LuaSnip", -- snippet engine
		"rafamadriz/friendly-snippets", -- useful snippets

		-- apperance
		--
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function(_, opts)
		local cmp = require("cmp")

		cmp.setup(opts)

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
				{ name = "buffer-lines" },
				{
					name = "cmdline_history",
					keyword_length = 3,
				},
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "async_path" },
				{
					name = "cmdline",
					keyword_length = 3,
				},
				{
					name = "cmdline_history",
					keyword_length = 3,
				},
			}),
		})

		cmp.setup.filetype("lua", {
			sources = cmp.config.sources({
				{ name = "nvim_lua" },
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "async_path" },
				{ name = "buffer" },
				{ name = "buffer-lines" },
			}),
		})

		cmp.setup.filetype("rust", {
			sources = cmp.config.sources({
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "async_path" },
				{ name = "buffer" },
				{
					name = "buffer-lines",
					keyword_length = 4,
				},
			}),
		})

		vim.api.nvim_create_autocmd("BufRead", {
			group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
			pattern = "Cargo.toml",
			callback = function()
				cmp.setup.buffer({
					sources = {
						{ name = "crates", group_index = 1 },
						{ name = "async_path", group_index = 1 },
						{ name = "buffer", group_index = 1 },
						{
							name = "buffer-lines",
							group_index = 1,
							keyword_length = 4,
						},

						{ name = "nvim_lsp", group_index = 2 },
					},
				})
			end,
		})
	end,
	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load() -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		return {
			sources = cmp.config.sources({
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "async_path" },
				{ name = "buffer" },
				{ name = "buffer-lines" },
			}),
			completion = {
				completeopt = "menu,menuone,preview,noselect,noinsert",
			},
			-- configure how nvim-cmp interacts with snippet engine
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = require("lspkind").cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
			-- `i` = insert mode, `c` = command mode, `s` = select mode
			mapping = {
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion

				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),

				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-c>"] = cmp.mapping.abort(),

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback) -- shift + tab
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
		}
	end,
}
