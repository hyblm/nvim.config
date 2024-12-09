return {
	{ "windwp/nvim-ts-autotag", opts = {} },
	"nvim-treesitter/nvim-treesitter-refactor",
	{ "nvim-treesitter/nvim-treesitter-context", opts = { multiline_threshold = 5 } },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- event = { "BufReadPre", "BufNewFile" },
		config = require("config.treesitter"),
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		opts = {
			textobjects = {
				lsp_interop = {
					enable = true,
					border = "none",
				},
				swap = {
					enable = true,
					swap_next = { ["<leader>a"] = "@parameter.inner" },
					swap_previous = { ["<leader>A"] = "@parameter.inner" },
				},
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["a="] = { query = "@assignment.outer" },
						["i="] = { query = "@assignment.inner" },
						["l="] = { query = "@assignment.lhs" },
						["r="] = { query = "@assignment.rhs" },

						["aa"] = { query = "@parameter.outer" },
						["ia"] = { query = "@parameter.inner" },

						["af"] = { query = "@function.outer" },
						["if"] = { query = "@function.inner" },
						["as"] = { query = "@local.scope" },
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
						["]z"] = "@fold",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[]"] = "@class.outer",
						["[z"] = "@fold",
					},
				},
			},
		},
	},
}
