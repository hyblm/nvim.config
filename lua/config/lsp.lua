local M = {}

M.lspconfig = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true)
			end
			local map = function(keys, func, description)
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. description })
			end

			map("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
			map("gA", vim.lsp.buf.references, "[g]oto [A]ll references")
			map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
			-- map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			map("<leader>.", vim.lsp.buf.code_action, "[C]ode [A]ction")
			-- map("K", vim.lsp.buf.hover, "Show Documentation")
		end,
	})

	local servers = {
		-- WebDev
		-- biome = {},
		tailwindcss = {},
		astro = {},
		volar = { init_options = { vue = { hybridMode = false } } },
		ts_ls = {
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "~/.local/share/nvim/mason/bin/vue-language-server",
						languages = { "vue" },
					},
				},
			},
		},
		-- systems
		clangd = {},
		ols = {},
		zls = {},
		rust_analyzer = {
			settings = {
				["rust-analyzer"] = {
					check = {
						command = "clippy",
						-- extraArgs = { "--", "-W", "clippy::pedantic" },
					},
				},
			},
		},
		-- scripting
		ruff = {},
		pyright = {},
		lua_ls = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = {
						checkThirdParty = false,
						library = {
							"${3rd}/luv/library",
							unpack(vim.api.nvim_get_runtime_file("", true)),
						},
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
		},
	}

	local lspconfig = require("lspconfig")
	local navic = require("nvim-navic")
	navic.setup({
		highlight = true,
		separator = " ⟩ ",
		click = true,
	})
	vim.api.nvim_set_hl(0, "NavicText", { default = false, italic = false, bg = "#000000", fg = "#888888" })
	vim.api.nvim_set_hl(0, "NavicSeparator", { default = false, bg = "#000000", fg = "#555555" })

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	for server_name, config in pairs(servers) do
		config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
		config.on_attach = function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
		end
		lspconfig[server_name].setup(config)
	end
end

M.conform = function()
	require("conform").setup({

		notify_on_error = true,
		format_on_save = {
			timeout_ms = 1500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff format" },
			vue = { "prettierd" },
			astro = { "prettierd" },
			typescript = { "prettierd" },
			javascript = { "prettierd" },
			typescriptreact = { "prettierd" },
			javascriptreact = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			markdown = { "prettierd" },
			rust = { "rustfmt" },
			c = { "clang_format" },
		},
		formatters = {
			clang_format = {
				prepend_args = {
					"--style={BasedOnStyle: Chromium, AllowShortIfStatementsOnASingleLine: AllIfsAndElse, AllowShortBlocksOnASingleLine: Always}",
				},
			},
		},
	})
end

M.lint = function()
	local lint = require("lint")
	lint.linters_by_ft = {
		vue = { "eslint_d" },
		astro = { "eslint_d" },
		typescript = { "biome" },
		javascript = { "biome" },
		typescriptreact = { "biome" },
		javascriptreact = { "biome" },
	}

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = vim.api.nvim_create_augroup("lint", { clear = true }),
		callback = function()
			lint.try_lint()
		end,
	})
end

return M
