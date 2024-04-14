return {
	"bluz71/vim-nightfly-colors",
	enabled = false,
	name = "nightfly",
	lazy = false,
	priority = 1000,
	init = function()
		vim.g.nightflyNormalFloat = true
		vim.g.nightflyTransparent = true

		vim.cmd.colorscheme("nightfly")
	end,
}
