return {
	"theprimeagen/harpoon",
	keys = {
		{
			"<leader>t",
			function()
				vim.cmd.split()
				require("harpoon.term").gotoTerminal(1)
				vim.cmd.startinsert()
			end,
			{ desc = "Open terminal using Harpoon in background (in Terminal mode)" },
		},
		{
			"<leader>T",
			function()
				vim.cmd.split()
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
		local harpoon = require("harpoon")

		harpoon.setup(opts)

		vim.keymap.set("t", "<C-x>", function()
			vim.cmd.stopinsert()
			vim.cmd.close()
		end, { desc = "Close terminal from Terminal mode" })

		vim.keymap.set("n", "<C-x>", function()
			vim.cmd.close()
		end, { desc = "Close terminal from Normal mode" })
	end,
}
