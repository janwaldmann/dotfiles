require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'neovim/nvim-lspconfig',
    commit = '67f151e84daddc86cc65f5d935e592f76b9f4496'
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
    tag = 'v0.9.1'
  }
  use { 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
  use 'tpope/vim-commentary'
  use 'sainnhe/gruvbox-material'
end)
