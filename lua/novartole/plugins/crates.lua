return {
	"saecki/crates.nvim",
	event = { "BufReadPre Cargo.toml" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		src = {
			cmp = {
				enabled = true, -- it's safe - no need cmp in deps
			},
		},
	},
}
