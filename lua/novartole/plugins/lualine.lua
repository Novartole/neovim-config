return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		local lazy_status = require("lazy.status")

		local MAX_BRANCH_NAME_LEN = 10
		local branch_name = ""

		local ft_is_not_nvimtree = function()
			return "NvimTree" ~= vim.bo.filetype
		end

		return {
			options = {
				theme = "catppuccin",
			},
			sections = {
				lualine_a = {
					{
						"mode",
						cond = function()
							return ft_is_not_nvimtree()
								or branch_name == ""
								or string.len(branch_name) > MAX_BRANCH_NAME_LEN
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						fmt = function(content, _)
							branch_name = content

							return content
						end,
						cond = function()
							return ft_is_not_nvimtree() or string.len(branch_name) <= MAX_BRANCH_NAME_LEN
						end,
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						cond = ft_is_not_nvimtree,
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
						cond = function()
							return ft_is_not_nvimtree() and lazy_status.has_updates()
						end,
						color = { fg = "#ff9e64" },
					},
					{
						"filesize",
						cond = ft_is_not_nvimtree,
					},
					{
						"encoding",
						cond = ft_is_not_nvimtree,
					},
					{
						"filetype",
						cond = ft_is_not_nvimtree,
					},
				},
				lualine_y = {
					"selectioncount",
					"progress",
				},
			},
		}
	end,
}
