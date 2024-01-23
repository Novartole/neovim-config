return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		check_ts = true, -- enable treesitter
	},
	config = function(_, opts)
		local autopairs = require("nvim-autopairs")

		autopairs.setup(opts)

		-- add a custom rule for closures of Rust
		local Rule = require("nvim-autopairs.rule")
		autopairs.add_rule(Rule("|", "|", "rust"):with_move(function()
			return true
		end))

		-- make autopairs and completion work together
		require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
	end,
}
