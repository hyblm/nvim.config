vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")
cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
		-- { name = "cmdline" },
		-- { name = "nvim_lua" },
		-- { name = "luasnip" },
	}),
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.SelectBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
		-- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
		-- ["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- ["<C-.>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Insert,
		-- 	select = true,
		-- }),
		-- ["<C-q>"] = cmp.mapping({
		-- 	i = cmp.mapping.abort(),
		-- 	c = cmp.mapping.close(),
		-- }),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	-- formatting = {
	-- 	format = lspkind.cmp_format({
	-- 		with_text = true,
	-- 		menu = {
	-- 			nvim_lsp = "[LSP]",
	-- 			buffer = "[buf]",
	-- 			nvim_lua = "[lua_api]",
	-- 			path = "[path]",
	-- 			cmdline = "[cmdline]",
	-- 			luasnip = "[snip]",
	-- 		},
	-- 	}),
	-- },
	-- experimental = {
	-- 	ghost_text = true,
	-- },
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer", keywork_length = 5 },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

local ls = require("luasnip")
ls.config.set_config({
	history = false,
	updateevents = "TextChanged,TextChangedI",
})
vim.keymap.set({ "i", "s" }, "<C-e>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })
