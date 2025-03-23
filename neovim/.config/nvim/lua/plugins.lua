require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'neovim/nvim-lspconfig',
    commit = 'fb733ac734249ccf293e5c8018981d4d8f59fa8f',
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
        'nvim-lua/plenary.nvim',
        'telescope-fzf-native.nvim',
      },
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      commit = '1f08ed60cafc8f6168b72b80be2b2ea149813e55',
      run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    },
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    commit = '20a7e40203dab3454686e057adecd805f3d6d334',
  }
  use { 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
  use 'tpope/vim-commentary'
  use 'lervag/vimtex'
  use 'sainnhe/gruvbox-material'
end)
