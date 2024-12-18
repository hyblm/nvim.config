return {
	{ "williamboman/mason.nvim", opts = {} },
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "astro", "ts_ls", "lua_ls", "clangd", "taplo", "ols", "tailwindcss" },
		},
	},
	{
		"S1M0N38/love2d.nvim",
		cmd = "LoveRun",
		opts = {},
		keys = {
			{ "<leader>v", ft = "lua", desc = "LÖVE" },
			{ "<leader>vv", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
			{ "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
		},
	},
	{ "neovim/nvim-lspconfig", config = require("config.lsp").lspconfig },
	{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	"onsails/lspkind.nvim",
	-- { "vxpm/ferris.nvim", opts = {} },
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = require("config.lsp").lint,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = require("config.lsp").conform,
	},
}
