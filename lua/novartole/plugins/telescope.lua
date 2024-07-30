return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	keys = {
		{ "<leader>ff", ":Telescope find_files<CR>", desc = "Fuzzy find files in cwd" },
		{ "<leader>fb", ":Telescope buffers<CR>", desc = "Fuzzy show ls" },
		{ "<leader>fs", ":Telescope live_grep<CR>", desc = "Find string in cwd" },
		{ "<leader>fc", ":Telescope grep_string<CR>", desc = "Find string under cursor in cwd" },
		{ "<leader>fn", ":Telescope notify<CR>", desc = "Search among notifications" },
	},
	event = "VeryLazy",
	opts = function()
		local actions = require("telescope.actions")

		return {
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		}
	end,
	config = function(_, opts)
		local telescope = require("telescope")

		telescope.setup(opts)
		telescope.load_extension("fzf")
	end,
}
