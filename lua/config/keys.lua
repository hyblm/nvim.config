vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "<space><space>z", function()
	print(vim.opt.foldenable._value)
	vim.opt.foldenable = not vim.opt.foldenable._value
end)
vim.keymap.set("n", "<space><space>b", function()
	require("barbecue.ui").toggle()
	-- local winbar = require("heirline").eval_winbar()
	-- if vim.o.winbar == "" then
	-- 	vim.o.winbar = winbar
	-- else
	-- 	vim.o.winbar = ""
	-- end
end)

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighLight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader><C-p>", [["*p]])

-- move back and forward in the quickfix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>cprevious<cr>")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<C-S-Space>", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end, opts)
