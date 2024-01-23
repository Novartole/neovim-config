return {
	"williamboman/mason.nvim",
	keys = {
		{ "<leader>M", vim.cmd.Mason, desc = "Open Mason" },
	},
	event = "VeryLazy",
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
			border = "rounded",
		},
	},
}
