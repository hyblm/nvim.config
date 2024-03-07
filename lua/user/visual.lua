return {
  {
    {
      'rebelot/kanagawa.nvim',
      lazy = false,
      config = function()
        vim.cmd([[colorscheme kanagawa-dragon]])
      end,
    },
    { 'nvim-lualine/lualine.nvim',   opts = {}, },
    { 'norcalli/nvim-colorizer.lua', opts = {}, },
    'kyazdani42/nvim-web-devicons',
  }
}
