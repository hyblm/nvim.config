return {
	"nvim-treesitter/nvim-treesitter-refactor",
	{ "nvim-treesitter/nvim-treesitter-context", opts = { multiline_threshold = 5 } },
	{ "IndianBoy42/tree-sitter-just", opts = {} },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
		opts = {
			ensure_installed = {
				"vimdoc",
				"rust",
				"odin",
				"c",
				"lua",
				"asm",
				"python",
				"javascript",
				"typescript",
                "css",
                "html",
				"astro",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			autotag = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			refactor = {
				-- highlight_current_scope = { enable = true },
				highlight_definitions = {
					enable = true,
					clear_on_cursor_move = true,
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		opts = {
			textobjects = {
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
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
						["as"] = { query = "@scope" },
					},
				},
			},
		},
	},
}
