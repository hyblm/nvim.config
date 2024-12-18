local telescope = require("telescope")

telescope.setup({
	theme = "dropdown",
	pickers = {
		find_files = {
			theme = "dropdown",
		},
	},
	defaults = {
		prompt_prefix = ":: ",
		mappings = {
			i = { ["<C-t>"] = require("trouble.sources.telescope").open },
			n = { ["<C-t>"] = require("trouble.sources.telescope").open },
		},
	},
	extensions = {
		fzf = {},
		file_browser = {
			theme = "ivy",
			hijack_netrw = true,
		},
	},
})
telescope.load_extension("ui-select")
telescope.load_extension("file_browser")
telescope.load_extension("fzf")

-- Telescope
local ts = require("telescope.builtin")
vim.keymap.set("n", "<leader>en", function()
	ts.find_files({ cwd = vim.fn.stdpath("config") })
end)
vim.keymap.set("n", "<leader>ep", function()
	ts.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end)
vim.keymap.set("n", "<leader>sg", ts.git_files)
vim.keymap.set("n", "<leader>sp", ts.find_files)
vim.keymap.set("n", "<leader>sb", ts.buffers)
vim.keymap.set("n", "<leader>sd", ts.diagnostics)
vim.keymap.set("n", "<leader>sh", ts.help_tags)
vim.keymap.set("n", "<leader>st", ":TodoTelescope<CR>")
vim.keymap.set("n", "gd", ts.lsp_definitions, { desc = "LSP: [g]oto [d]efinition" })
vim.keymap.set("n", "gr", ts.lsp_references, { desc = "LSP: [g]oto [r]eferences" })
vim.keymap.set("n", "gI", ts.lsp_implementations, { desc = "LSP: [g]oto [I]implementation" })
vim.keymap.set("n", "<leader>df", ts.lsp_type_definitions, { desc = "LSP: type [D]efinition" })
vim.keymap.set("n", "<leader>ds", ts.lsp_document_symbols, { desc = "LSP: [D]ocument [S]ymbols" })
vim.keymap.set("n", "<leader>ws", ts.lsp_workspace_symbols, { desc = "LSP: [W]orkspace [S]ymbols" })

vim.keymap.set("n", " /", function()
	ts.current_buffer_fuzzy_find(require("telescope.themes").get_ivy({}))
end, { desc = "[/] Fuzzy find in current buffer" })

vim.keymap.set("n", "<leader>g/", function()
	ts.live_grep(require("telescope.themes").get_ivy({}))
end, { desc = "[g/] global fuzzy find" })
