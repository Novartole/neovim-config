return {
	"lvimuser/lsp-inlayhints.nvim",
	lazy = true,
	opts = {
		inlay_hints = {
			type_hints = {
				prefix = "▸ ",
				remove_colon_start = true,
			},
			labels_separator = " ",
			highlight = "DapUIBreakpointsDisabledLine",
		},
	},
}
