return {
	"mbbill/undotree",
	keys = {
		{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
	},
	init = function()
		vim.g.undotree_SplitWidth = 32
	end,
}
