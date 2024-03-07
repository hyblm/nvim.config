return {
  {
    { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
    { 'IndianBoy42/tree-sitter-just', opts = {} },
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { 'rust', 'c', 'lua' },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        refactor = {
          highlight_current_scope = { enable = true },
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
          },
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = true,
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['a='] = { query = '@assignment.outer' },
            ['i='] = { query = '@assignment.inner' },
            ['l='] = { query = '@assignment.lhs' },
            ['r='] = { query = '@assignment.rhs' },

            ['aa'] = { query = '@parameter.outer' },
            ['ia'] = { query = '@parameter.inner' },
          },
        },
      },
    },
  },
}
