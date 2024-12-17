return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		-- engine
		"L3MON4D3/LuaSnip",
		-- source for neovim's built-in LSP
		-- name = "nvim_lsp"
		"hrsh7th/cmp-nvim-lsp",
		-- source for text in buffer
		-- name = "buffer"
		"hrsh7th/cmp-buffer",
		-- source for all the lines in the current buffer
		-- name = "buffer-lines"
		"amarakon/nvim-cmp-buffer-lines",
		-- source for filesystem paths with async processing
		-- name = "async_path"
		"FelipeLema/cmp-async-path",
		-- source for from command-line histories
		-- name = "cmdline_history"
		"dmitmel/cmp-cmdline-history",
		-- source for Neovim Lua API such vim.lsp.*
		-- name = "nvim_lua"
		"hrsh7th/cmp-nvim-lua",
		-- vs-code like pictograms
		"onsails/lspkind.nvim",
	},
	config = function(_, opts)
		local cmp = require("cmp")

		cmp.setup(opts)

		cmp.setup.cmdline({ "/", "?" }, {
			-- turn on navigation via TAB and S-TAB in Command mode
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{
					name = "buffer",
					keyword_length = 2,
					group_index = 2,
				},
				{
					name = "cmdline_history",
					keyword_length = 3,
					group_index = 1,
				},
			},
		})

		cmp.setup.filetype("lua", {
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{
					name = "buffer",
					keyword_length = 3,
				},
				{
					name = "async_path",
					trigger_characters = { "/" },
				},
			}),
		})

		cmp.setup.filetype("rust", {
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					keyword_length = 2,
					group_index = 1,
				},
				{
					name = "buffer",
					keyword_length = 3,
					group_index = 1,
				},
				{
					name = "buffer-lines",
					keyword_length = 4,
					group_index = 2,
				},
				{
					name = "async_path",
					trigger_characters = { "/" },
					group_index = 1,
				},
			}),
		})

		vim.api.nvim_create_autocmd("BufRead", {
			group = vim.api.nvim_create_augroup("CmpSourceCargo", {}),
			pattern = "Cargo.toml",
			callback = function()
				cmp.setup.buffer({
					sources = {
						{ name = "crates" },
						{ name = "nvim_lsp" },
						{
							name = "async_path",
							trigger_characters = { "/" },
						},
						{
							name = "buffer",
							keyword_length = 3,
						},
					},
				})
			end,
		})
	end,
	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- needs for selection on TAB and S-TAB
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		return {
			snippet = {
				-- required option
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			-- use these sources if no match among explicit configurations
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					keyword_length = 2,
				},
				{
					name = "buffer",
					keyword_length = 3,
				},
				{
					name = "async_path",
					trigger_characters = { "/" },
				},
			}),
			completion = {
				completeopt = "menu,menuone,preview,noselect,noinsert",
			},
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = require("lspkind").cmp_format({
					mode = "symbol",
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
			window = {
				completion = {
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
					col_offset = 2,
					side_padding = 2,
					scrollbar = false,
				},
				documentation = {
					border = {
						{ " ", "FloatBorder" },
						{ " ", "FloatBorder" },
						{ " ", "FloatBorder" },
						{ " ", "FloatBorder" },
						{ " ", "FloatBorder" },
						{ " ", "FloatBorder" },
						{ " ", "FloatBorder" },
						{ " ", "FloatBorder" },
					},
				},
			},
			-- `i` = insert mode, `c` = command mode, `s` = select mode
			mapping = {
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), -- next suggestion

				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),

				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-c>"] = cmp.mapping.abort(),

				-- move next on TAB
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

				-- move back on S-TAB
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
