return {
	"SmiteshP/nvim-navic",
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"lewis6991/hover.nvim",
		enabled = true,
		config = function()
			require("hover").setup({
				init = function()
					-- Require providers
					require("hover.providers.lsp")
					require("hover.providers.gh")
					require("hover.providers.gh_user")
					-- require('hover.providers.jira')
					require("hover.providers.dap")
					require("hover.providers.fold_preview")
					-- require('hover.providers.diagnostic')
					-- require('hover.providers.man')
					require("hover.providers.dictionary")
				end,
				preview_opts = {
					border = "single",
				},
				-- Whether the contents of a currently open hover window should be moved
				-- to a :h preview-window when pressing the hover keymap.
				preview_window = false,
				title = true,
				mouse_providers = {
					"LSP",
				},
				mouse_delay = 1000,
			})

			-- Setup keymaps
			vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
			vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
			vim.keymap.set("n", "<C-p>", function()
				require("hover").hover_switch("previous")
			end, { desc = "hover.nvim (previous source)" })
			vim.keymap.set("n", "<C-n>", function()
				require("hover").hover_switch("next")
			end, { desc = "hover.nvim (next source)" })

			-- Mouse support
			vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
			vim.o.mousemoveevent = true
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end)

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk)
				map("n", "<leader>hr", gitsigns.reset_hunk)
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>hS", gitsigns.stage_buffer)
				map("n", "<leader>hu", gitsigns.undo_stage_hunk)
				map("n", "<leader>hR", gitsigns.reset_buffer)
				map("n", "<leader>hp", gitsigns.preview_hunk)
				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end)
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
				map("n", "<leader>hd", gitsigns.diffthis)
				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end)
				map("n", "<leader>td", gitsigns.toggle_deleted)

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon.setup()

			vim.keymap.set("n", "<leader>h", function()
				harpoon:list():append()
			end)
			vim.keymap.set("n", "<C-h>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
			vim.keymap.set("n", "<C-c>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-t>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-s>", function()
				harpoon:list():select(4)
			end)

			vim.keymap.set("n", "<C-S-P>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-S-N>", function()
				harpoon:list():next()
			end)
		end,
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup()
			-- require("mini.clue").setup() -- which key replacement
			require("mini.surround").setup()
			require("mini.pairs").setup()
			-- require("mini.statusline").setup()
			local hi = require("mini.hipatterns")
			hi.setup({
				highlighters = {
					hex_color = hi.gen_highlighter.hex_color(),
				},
			})
			-- require 'mini.operators'.setup()
		end,
	},
	"nvim-telescope/telescope-ui-select.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					prompt_prefix = ":: ",
					mappings = {
						i = { ["<C-t>"] = require("trouble.sources.telescope").open },
						n = { ["<C-t>"] = require("trouble.sources.telescope").open },
					},
				},
				extensions = {
					file_browser = {
						theme = "ivy",
						hijack_netrw = true,
					},
				},
			})
			telescope.load_extension("ui-select")
			telescope.load_extension("file_browser")
			--telescope.load_extension 'fzf'

			-- Telescope
			local ts = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sg", ts.git_files)
			vim.keymap.set("n", "<leader>sp", ts.find_files)
			vim.keymap.set("n", "<leader>sb", ts.buffers)
			vim.keymap.set("n", "<leader>sd", ts.diagnostics)
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
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			keywords = { WARN = { alt = { "ASSUMPTION" } } },
		},
	},
	"nanotee/zoxide.vim",
	{ "numToStr/Comment.nvim", opts = {} },
}
