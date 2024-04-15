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
			config = function()
				vim.cmd([[colorscheme kanagawa-dragon]])
			end,
		},
		{ "norcalli/nvim-colorizer.lua", opts = {} },
		"kyazdani42/nvim-web-devicons",
        {
            "j-hui/fidget.nvim",
            opts = {},
        }
	},
}
