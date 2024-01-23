return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	keys = {
		{ "<leader>ee", vim.cmd.NvimTreeToggle, desc = "Toggle file explorer" },
		{ "<leader>eff", vim.cmd.NvimTreeFindFileToggle, desc = "Toggle file explorer on current file" },
		{ "<leader>ef", vim.cmd.NvimTreeFindFile, desc = "Open file explorer on current file" },
		{ "<leader>ec", vim.cmd.NvimTreeCollapse, desc = "Collapse file explorer" },
		{ "<leader>er", vim.cmd.NvimTreeRefresh, desc = "Refresh file explorer" },
	},
	init = function()
		-- recommended settings from nvim-tree documentation
		--
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	opts = {
		view = {
			width = 35,
			relativenumber = true,
		},
		renderer = {
			indent_markers = {
				enable = true,
			},
			icons = {
				glyphs = {
					folder = {
						arrow_closed = "", -- arrow when folder is closed
						arrow_open = "", -- arrow when folder is open
					},
				},
			},
		},
		-- disable window_picker for explorer to work well with window splits
		actions = {
			open_file = {
				window_picker = {
					enable = false,
				},
			},
			file_popup = {
				open_win_config = {
					border = "rounded",
				},
			},
		},
		-- files that won't be shown
		filters = {
			custom = { ".DS_Store", "^.git$" },
			git_ignored = false,
		},
	},
}
