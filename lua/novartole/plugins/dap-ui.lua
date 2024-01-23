return {
	"rcarriga/nvim-dap-ui",
	keys = {
		{
			"<F1>",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle DAP UI",
		},
		{
			"<F2>",
			function()
				require("dapui").eval()
			end,
			desc = "DAP Eval",
			mode = { "n", "v" },
		},
		{
			"<F3>",
			function()
				require("dapui").float_element("breakpoints")
			end,
			desc = "DAP List Breakpoints",
			mode = { "n", "v" },
		},
	},
	config = function(_, opts)
		local dapui = require("dapui")

		dapui.setup(opts)

		local dap = require("dap")

		-- open and close windows automatically
		--
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
