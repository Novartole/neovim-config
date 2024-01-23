return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
	opts = {
		flavour = "mocha",
		transparent_background = true,
		-- turn on non-default integrations
		integrations = {
			harpoon = true,
			mason = true,
			noice = true,
			notify = true,
		},
	},
}
