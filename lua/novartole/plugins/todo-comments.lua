return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<leader>ftd", vim.cmd.TodoTelescope, desc = "Find todo-comments via Telescope" },
	},
	config = true,
}
