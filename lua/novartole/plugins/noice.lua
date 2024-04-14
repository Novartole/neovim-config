return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	event = "VeryLazy",
	opts = {
		cmdline = {
			format = {
				cmdline = {
					conceal = false,
				},
				search_down = {
					icon = "⌄",
				},
				search_up = {
					icon = "⌃",
				},
				filter = {
					conceal = false,
				},
				help = {
					conceal = false,
				},
				lua = {
					conceal = false,
				},
			},
		},
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			hover = {
				opts = {
					border = {
						style = {
							{ "╭", "FloatBorder" },
							{ " ", "FloatBorder" },
							{ "╮", "FloatBorder" },
							{ " ", "FloatBorder" },
							{ "╯", "FloatBorder" },
							{ " ", "FloatBorder" },
							{ "╰", "FloatBorder" },
							{ " ", "FloatBorder" },
						},
						padding = { 0, 2 },
					},
					position = {
						row = 2,
						col = 2,
					},
				},
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
			{
				filter = {
					event = "cmdline",
					find = "^.*:%d?,?%d?s/",
				},
				view = "cmdline",
			},
		},
		presets = {
			command_palette = true,
			long_message_to_split = true,
		},
	},
	config = function(_, opts)
		require("noice").setup(opts)

		local keymap = vim.keymap
		local _opts = { silent = true, expr = true }

		keymap.set({ "n", "i", "s" }, "<c-d>", function()
			if not require("noice.lsp").scroll(4) then
				return "<c-d>"
			end
		end, vim.tbl_extend("force", _opts, { desc = "Remap scroll-down when noice.lsp" }))

		keymap.set({ "n", "i", "s" }, "<c-u>", function()
			if not require("noice.lsp").scroll(-4) then
				return "<c-u>"
			end
		end, vim.tbl_extend("force", _opts, { desc = "Remap scroll-up when noice.lsp" }))
	end,
}
