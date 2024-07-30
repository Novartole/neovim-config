return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function(_, opts)
		local cond = require("nvim-autopairs.conds")
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")

		npairs.setup(opts)

		-- Rust closure with no args, e.g. std::thread::spawn(|| (cursor here; note a space right before the cursor)
		for _, prefix_empty in pairs({ "spawn(", "spawn(move ", ".ok_or_else(", ".map_or_else(" }) do
			npairs.add_rule(Rule(prefix_empty .. "|", "| ", "rust"):with_pair(cond.done()):set_end_pair_length(0))
		end

		-- Rust closure with arg(s), e.g. let f = |(cursor here)|
		for _, prefix_not_empty in pairs({ "(", "(move ", "= ", "= move ", ", " }) do
			npairs.add_rule(Rule(prefix_not_empty .. "|", "|", "rust"):with_pair(cond.done()))
		end
	end,
}
