require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'neovim/nvim-lspconfig',
    tag = 'v0.1.7'
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
    },
  }
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'telescope-frecency.nvim',
      },
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      requires = 'tami5/sql.nvim',
    },
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    commit = 'c06292fdc641d71d185d2f1a507ad8232b6cf528'
  }
  use { 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
  use 'tpope/vim-commentary'
  use 'lervag/vimtex'
  use 'sainnhe/gruvbox-material'
end)
