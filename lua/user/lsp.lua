return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, description)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. description })
          end

          -- local search = require 'telescope.builtin'
          -- binomial_heap_tif search then
          --   map('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
          --   map('gr', vim.lsp.buf.references, '[g]oto [r]eferences')
          --   map('gI', vim.lsp.buf.implementation, '[g]oto [I]implementation')
          --   map('<leader>D', vim.lsp.buf.type_definition, 'type [D]efinition')
          --   map('<leader>ds', vim.lsp.buf.document_symbol, '[d]ocument [s]ymbols')
          --   map('<leader>ws', vim.lsp.buf.workspace_symbol, '[w]orkspace [s]ymbols')
          -- else
          -- map('gd', search.lsp_definitions, '[g]oto [d]efinition')
          -- map('gr', search.lsp_references, '[g]oto [r]eferences')
          -- map('gI', search.lsp_implementation, '[g]oto [I]implementation')
          -- map('<leader>D', search.lsp_type_definitions, 'type [D]efinition')
          -- map('<leader>ds', search.lsp_document_symbols, '[D]ocument [S]ymbols')
          -- map('<leader>ws', search.lsp_workspace_symbols, '[W]orkspace [S]ymbols')
          -- end

          map('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>a', vim.lsp.buf.code_action, '[C]ode [A]action')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Show Documentation')

          -- local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- if client and client.server_capabilities.documentHighlightProvider then
          --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          --     buffer = event.buf,
          --     callback = vim.lsp.buf.document_highlight,
          --   })
          --
          --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          --     buffer = event.buf,
          --     callback = vim.lsp.buf.clear_references,
          --   })
          -- end
        end
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {},
        rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                diagnostics = { disable = { 'missing-fields' } },
              },
            },
          },
        },
      }

      local lspconfig = require 'lspconfig'
      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        lspconfig[server_name].setup(server)
      end
    end
  },
  'onsails/lspkind.nvim',
  { 'vxpm/ferris.nvim', opts = {} },
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^4',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'mfussenegger/nvim-dap',
  --   },
  --   ft = { 'rust' },
  -- },
  {
    'stevearc/conform.nvim',
    -- event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt' },
        c = { 'clang_format' },
      },
      formatters = {
        clang_format = {
          prepend_args = { '-fallback-style=microsoft' },
        },
      },
    },
  },
}
