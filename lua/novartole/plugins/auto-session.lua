return {
	"rmagatti/auto-session",
	keys = {
		{ "<leader>wr", vim.cmd.SessionRestore, { desc = "Restore session" } },
		{ "<leader>ws", vim.cmd.SessionSave, { desc = "Save current session" } },
		{
			"<leader>wf",
			":Autosession search<CR>",
			{ desc = "Search a session" },
		},
		{
			"<leader>wd",
			":Autosession delete<CR>",
			{ desc = "Delete a session" },
		},
	},
	opts = {
		auto_session_enable_last_session = false,
		auto_session_create_enabled = false,
		auto_save_enabled = false,
		auto_restore_enabled = false,
		auto_session_use_git_branch = false,
	},
}
