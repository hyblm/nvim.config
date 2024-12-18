return {
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local highlight = {
				"CursorColumn",
				"Whitespace",
			}
			require("ibl").setup(
				---@module "ibl"
				---@type ibl.config
				{
					indent = {
						highlight = highlight,
						char = "",
					},
					whitespace = {
						highlight = highlight,
						remove_blankline_trail = false,
					},
					scope = { enabled = true, highlight = { "Function", "Label" } },
				}
			)
		end,
	},
	{
		"rebelot/heirline.nvim",
		main = "heirline",
		config = function()
			require("config.heirline")
		end,
		dependencies = {
			"rebelot/terminal.nvim",
		},
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
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
						CursorLine = { bg = "#000000" },
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },
					}
				end,
			})
		end,
		init = function()
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	{
		"folke/noice.nvim",
		enabled = true,
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				command_palette = true,
			},
		},
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{ "j-hui/fidget.nvim", opts = {} },
	"kyazdani42/nvim-web-devicons",
	"folke/twilight.nvim",
	"folke/zen-mode.nvim",
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
}
