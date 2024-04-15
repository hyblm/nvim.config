local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",

	-- 'Olical/conjure',
	require("user.treesitter"),
	require("user.completion"),
	require("user.navigation"),
	require("user.lsp"),

	require("user.visual"),
})
