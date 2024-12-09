return function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"rust",
			"python",
			"zig",
			"odin",
			"scheme",
		},
		sync_install = false,
		auto_install = true,
		ignore_install = {},
		modules = {},

		highlight = {
			enable = true,
			-- disable = function(lang, buf)
			-- 	local max_filesize = 100 * 1024 -- 100 KB
			-- 	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			-- 	if ok and stats and stats.size > max_filesize then
			-- 		return true
			-- 	end
			-- end,
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		indent = { enable = true },
		refactor = {
			highlight_definitions = {
				enable = true,
				clear_on_cursor_move = true,
			},
			-- highlight_current_scope = { enable = true },
			-- smart_rename = {
			-- 	enable = true,
			-- 	keymaps = {
			-- 		smart_rename = "grn",
			-- 	},
			-- },
		},
	})
end
