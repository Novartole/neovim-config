return {
	"saecki/crates.nvim",
	event = { "BufReadPre Cargo.toml" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		completion = {
			cmp = {
				enabled = true,
			},
		},
		popup = {
			autofocus = true,
		},
	},
}
