local options = {
	compatible = false,
	number = true,
	relativenumber = true,

	termguicolors = true,
	-- background = "dark",
	cursorline = true,
	cursorcolumn = true,
	laststatus = 3,
	signcolumn = "yes",
	colorcolumn = "100",
	listchars = { tab = "󰌒  ", trail = "󱁐", eol = "󰌑" },

	mouse = "a",
	scrolloff = 10,
	sidescrolloff = 10,
	splitbelow = true,
	splitright = true,

	hidden = true,
	errorbells = false,

	tabstop = 2,
	softtabstop = 4,
	shiftwidth = 2,
	expandtab = true,
	autoindent = true,

	smartindent = true,
	wrap = false,

	incsearch = true,
	hlsearch = true,
	ignorecase = true,
	smartcase = true,

	swapfile = false,
	backup = false,
	undofile = true,

	ttyfast = true,
	fileencoding = "utf-8",
	backspace = "indent,eol,start",
	-- clipboard = "unnamedplus",
	-- guifont = "Fira Code:h11",
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

vim.opt.shortmess:append("c")
vim.g.mapleader = " "

vim.cmd([[highlight Normal guibg=none]]) -- use the background of the terminal emulator

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true,
	float = {
		focusable = false,
		style = "minimal",
		-- border = "rounded",
		header = "",
		prefix = "",
	},
	signs = { active = signs },
})
