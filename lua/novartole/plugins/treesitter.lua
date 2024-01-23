return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		opts = {
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			ensure_installed = {
				"c",
				"vimdoc",
				"json",
				"yaml",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"dockerfile",
				"gitignore",
				"toml",
				"rust",
				"proto",
				"regex",
			},
			auto_install = true, -- auto install above language parsers
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>v",
					node_incremental = "<leader>a",
					scope_incremental = false,
					node_decremental = "<leader>i",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },

						["a:"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
						["i:"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

						["a?"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
						["i?"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

						["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
						["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

						["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
						["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

						["am"] = {
							query = "@function.outer",
							desc = "Select outer part of a method/function definition",
						},
						["im"] = {
							query = "@function.inner",
							desc = "Select inner part of a method/function definition",
						},

						["as"] = { query = "@class.outer", desc = "Select outer part of a class" },
						["is"] = { query = "@class.inner", desc = "Select inner part of a class" },
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]f"] = { query = "@call.outer", desc = "Next function call start" },
						["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
						["]s"] = { query = "@class.outer", desc = "Next class start" },
						["]?"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["]l"] = { query = "@loop.outer", desc = "Next loop start" },
					},
					goto_previous_start = {
						["[f"] = { query = "@call.outer", desc = "Prev function call start" },
						["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
						["[s"] = { query = "@class.outer", desc = "Prev class start" },
						["[?"] = { query = "@conditional.outer", desc = "Prev conditional start" },
						["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
