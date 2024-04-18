return {
	{
		"folke/tokyonight.nvim",
		"folke/twilight.nvim",
		"folke/zen-mode.nvim",
		"rockerBOO/boo-colorscheme-nvim",
		"rose-pine/neovim",
		{
			"rebelot/kanagawa.nvim",
			lazy = false,
            opts = {
                transparent = true,
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            }
                        }
                    }
                },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },  -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },
                }
            end,
            },
            -- config = function()
            --      vim.api.nvim_create_autocmd("ColorScheme", {
            --         pattern = "kanagawa",
            --         callback = function()
            --             if vim.o.background == "light" then
            --                 vim.fn.system("kitty +kitten themes Kanagawa_light")
            --             elseif vim.o.background == "dark" then
            --                 vim.fn.system("kitty +kitten themes Kanagawa_dragon")
            --             else
            --                 vim.fn.system("kitty +kitten themes Kanagawa")
            --             end
            --         end,
            --     })
            -- end
		},
		{ "norcalli/nvim-colorizer.lua", opts = {} },
		"kyazdani42/nvim-web-devicons",
        {
            "j-hui/fidget.nvim",
            opts = {},
        }
	},
}
