return {
  {
    {
      'echasnovski/mini.nvim',
      version = '*',
      config = function ()
        require 'mini.ai'.setup()
        require 'mini.surround'.setup()
        require 'mini.pairs'.setup()
        -- require 'mini.operators'.setup()
      end
    },
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope.nvim',
      config = function()
        local telescope = require 'telescope'

        telescope.setup {
          defaults = {
            prompt_prefix = ":: "
          },
          extensions = {
            file_browser = {
              theme = "ivy",
              hijack_netrw = true,
            }
          }
        }
        telescope.load_extension 'ui-select'
        --require('telescope').load_extension 'fzf'
        --require('telescope').load_extension 'file_browser'
        --require('telescope').load_extension 'ui-select'

        -- Telescope
        local search = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sf', search.find_files)
        vim.keymap.set('n', '<leader>sg', search.live_grep)
        vim.keymap.set('n', '<leader>sd', search.diagnostics)
        vim.keymap.set('n', '<leader>st', ':TodoTelescope<CR>')
        vim.keymap.set('n', 'gd', search.lsp_definitions, { desc = 'LSP: [g]oto [d]efinition' })
        vim.keymap.set('n', 'gr', search.lsp_references, { desc = 'LSP: [g]oto [r]eferences' })
        vim.keymap.set('n', 'gI', search.lsp_implementations, { desc = 'LSP: [g]oto [I]implementation' })
        vim.keymap.set('n', '<leader>D', search.lsp_type_definitions, { desc = 'LSP: type [D]efinition' })
        vim.keymap.set('n', '<leader>ds', search.lsp_document_symbols, { desc = 'LSP: [D]ocument [S]ymbols' })
        vim.keymap.set('n', '<leader>ws', search.lsp_workspace_symbols, { desc = 'LSP: [W]orkspace [S]ymbols' })
        -- vim.keymap.set( 'n', ' nv', :cd lua function()
        --   require 'telescope.builtin'.find_files()
        -- end, {desc = ""})
        vim.keymap.set('n', ' /', function()
          require 'telescope.builtin'.current_buffer_fuzzy_find(require('telescope.themes').get_ivy {})
        end, { desc = '[/] Fuzzy find in current buffer' })
      end,
    },
    {
      'folke/trouble.nvim',
      init = function()
        vim.keymap.set('n', '<leader>xx', function() require('trouble').toggle() end)
        vim.keymap.set('n', '<leader>xw', function() require('trouble').toggle('workspace_diagnostics') end)
        vim.keymap.set('n', '<leader>xd', function() require('trouble').toggle('document_diagnostics') end)
        vim.keymap.set('n', '<leader>xq', function() require('trouble').toggle('quickfix') end)
        vim.keymap.set('n', '<leader>xl', function() require('trouble').toggle('loclist') end)
        vim.keymap.set('n', '<leader>xt', function() require('trouble').toggle('todo') end)
        vim.keymap.set('n', 'gR', function() require('trouble').toggle('lsp_references') end)
      end,
    },
    {
      'folke/todo-comments.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = {
        highlight = { pattern = [[.*<(KEYWORDS)\s*\(.*\):]], },
        search = { pattern = [[]] },
      },
    },
    'nanotee/zoxide.vim',
    { 'numToStr/Comment.nvim', opts = {}, },
  }
}
