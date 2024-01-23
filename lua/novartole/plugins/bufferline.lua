return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	event = "TabEnter",
	opts = function()
		return {
			highlights = require("catppuccin.groups.integrations.bufferline").get(),
			options = {
				mode = "tabs",
				separator_style = "slant",
				always_show_bufferline = false,
			},
		}
	end,
}
