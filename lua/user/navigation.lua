return {
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
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
			vim.keymap.set("n", "<C-f>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-d>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-s>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-a>", function()
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
		version = "*",
		config = function()
			require("mini.ai").setup()
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.statusline").setup()
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
						i = { ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble },
						n = { ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble },
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
			local search = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sf", search.git_files)
			vim.keymap.set("n", "<leader>sa", search.find_files)
			vim.keymap.set("n", "<leader>sd", search.diagnostics)
			vim.keymap.set("n", "<leader>st", ":TodoTelescope<CR>")
			vim.keymap.set("n", "gd", search.lsp_definitions, { desc = "LSP: [g]oto [d]efinition" })
			vim.keymap.set("n", "gr", search.lsp_references, { desc = "LSP: [g]oto [r]eferences" })
			vim.keymap.set("n", "gI", search.lsp_implementations, { desc = "LSP: [g]oto [I]implementation" })
			vim.keymap.set("n", "<leader>df", search.lsp_type_definitions, { desc = "LSP: type [D]efinition" })
			vim.keymap.set("n", "<leader>ds", search.lsp_document_symbols, { desc = "LSP: [D]ocument [S]ymbols" })
			vim.keymap.set("n", "<leader>ws", search.lsp_workspace_symbols, { desc = "LSP: [W]orkspace [S]ymbols" })

			vim.keymap.set("n", " /", function()
				search.current_buffer_fuzzy_find(require("telescope.themes").get_ivy({}))
			end, { desc = "[/] Fuzzy find in current buffer" })

			vim.keymap.set("n", "<leader>g/", function()
				search.live_grep(require("telescope.themes").get_ivy({}))
			end, { desc = "[g/] global fuzzy find" })
		end,
	},
	{
		"folke/trouble.nvim",
		init = function()
			local t = require("trouble")
			vim.keymap.set("n", "<leader>xx", function()
				t.toggle()
			end)
			vim.keymap.set("n", "<leader>xw", function()
				t.toggle("workspace_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xd", function()
				t.toggle("document_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xq", function()
				t.toggle("quickfix")
			end)
			vim.keymap.set("n", "<leader>xl", function()
				t.toggle("loclist")
			end)
			vim.keymap.set("n", "<leader>xt", function()
				t.toggle("todo")
			end)
			vim.keymap.set("n", "gR", function()
				t.toggle("lsp_references")
			end)
			vim.keymap.set("n", "]t", function()
				t.next({ skip_groups = true, jump = true })
			end)
			vim.keymap.set("n", "[t", function()
				t.previous({ skip_groups = true, jump = true })
			end)
			vim.keymap.set("n", "<leader>x[", function()
				t.first({ skip_groups = true, jump = true })
			end)
			vim.keymap.set("n", "<leader>x]", function()
				t.last({ skip_groups = true, jump = true })
			end)
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			highlight = { pattern = [[.*<(KEYWORDS)\s*\(.*\):]] },
			search = { pattern = [[]] },
		},
	},
	"nanotee/zoxide.vim",
	{ "numToStr/Comment.nvim", opts = {} },
}
