return {
	"theprimeagen/harpoon",
	keys = {
		{
			"<leader>t",
			function()
				local cmd = vim.cmd
				cmd.split()
				require("harpoon.term").gotoTerminal(1)
				cmd.startinsert()
			end,
			{ desc = "Open terminal using Harpoon in background (in Terminal mode)" },
		},
		{
			"<leader>T",
			function()
				local cmd = vim.cmd
				cmd.split()
				require("harpoon.term").gotoTerminal(1)
			end,
			{ desc = "Open terminal using Harpoon in background (in Normal mode)" },
		},
		{
			"<leader>hm",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			{ desc = "Show Harpoon menu" },
		},
	},
	config = function(_, opts)
		require("harpoon").setup(opts)

		local cmd = vim.cmd

		vim.keymap.set("t", "<C-x>", function()
			cmd.stopinsert()
			cmd.close()
		end, { desc = "Close terminal from Terminal mode" })

		vim.keymap.set("n", "<C-x>", function()
			cmd.close()
		end, { desc = "Close terminal from Normal mode" })
	end,
}
