return {
	"RRethy/vim-illuminate",
	lazy = false,
	keys = {
		{ "<leader>ill", vim.cmd.IlluminateToggle, desc = "Toggle illumination" },
		{
			"]i",
			function()
				require("illuminate").goto_next_reference(true)
			end,
			desc = "Move the cursor to the next closest references",
		},
		{
			"[i]",
			function()
				require("illuminate").goto_prev_reference(true)
			end,
			desc = "Move the cursor to the prev closest references",
		},
	},
	config = function()
		require("illuminate").configure()
	end,
}
