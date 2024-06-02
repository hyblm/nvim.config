return {
	{
		"folke/tokyonight.nvim",
		"folke/twilight.nvim",
		"folke/zen-mode.nvim",
		"rockerBOO/boo-colorscheme-nvim",
		"nyoom-engineering/oxocarbon.nvim",
		"rose-pine/neovim",
		{
			"stevearc/dressing.nvim",
			event = "VeryLazy",
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufReadPre", "bufNewFile" },
			main = "ibl",
			opts = {
				indent = {
					--   highlight = {
					--     "StatusLine",
					--     "Whitespace",
					--   },
					char = "",
				},
				whitespace = {
					highlight = {
						"StatusLine",
						"Whitespace",
					},
					remove_blankline_trail = false,
				},
			},
		},
		{
			"rebelot/kanagawa.nvim",
			lazy = false,
			priority = 1000,
			opts = {
				transparent = true,
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors)
					local theme = colors.theme
					return {
						CursorLine = { bg = theme.ui.bg_m1 },
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },
					}
				end,
			},
		},
		{ "norcalli/nvim-colorizer.lua", opts = {} },
		{ "j-hui/fidget.nvim", opts = {} },
		"kyazdani42/nvim-web-devicons",
	},
}
