return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		local lazy_status = require("lazy.status")

		return {
			options = {
				theme = "catppuccin",
			},
			sections = {
				lualine_a = {
					"mode",
				},
				lualine_b = {
					"branch",
				},
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic", "nvim_lsp" },
						update_in_insert = true,
					},
					{
						function()
							return "  " .. require("dap").status()
						end,
						cond = function()
							return package.loaded["dap"] and require("dap").status() ~= ""
						end,
					},
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					"filesize",
					"encoding",
					"filetype",
				},
				lualine_y = {
					"selectioncount",
					"progress",
				},
			},
		}
	end,
}
