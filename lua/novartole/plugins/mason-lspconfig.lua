return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim" },
	lazy = true,
	opts = {
		-- list of servers for mason to install
		ensure_installed = {
			"rust_analyzer",
		},
		-- auto-install configured servers (with lspconfig)
		automatic_installation = {
			exclude = {
				"rust_analyzer",
			},
		},
	},
}
