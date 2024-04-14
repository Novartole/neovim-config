return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"jbyuki/one-small-step-for-vimkind",
	},
	keys = {
		{ "<F4>", vim.cmd.DapTerminate, desc = "DAP Terminate" },
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "DAP Continue",
		},
		{
			"<F6>",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<F7>",
			function()
				require("dap").goto_()
			end,
			desc = "Go to line (skip)",
		},
		{ "<leader>bb", vim.cmd.DapToggleBreakpoint, desc = "Toggle Breakpoint" },
		{
			"<leader>bc",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Breakpoint Condition",
		},
		{ "<F10>", vim.cmd.DapStepOver, desc = "Step Over" },
		{ "<F11>", vim.cmd.DapStepInto, desc = "Step Into" },
		{ "<F12>", vim.cmd.DapStepOut, desc = "Step Out" },
	},
	config = function()
		local dap = require("dap")

		dap.configurations.lua = {
			{
				type = "nlua",
				request = "attach",
				name = "Attach to running Neovim instance",
			},
		}

		dap.adapters.nlua = function(callback, config)
			callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
		end
	end,
}
