return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  opts = {
    ensure_installed = { 'bash', 'c', 'cmake', 'cpp', 'cuda', 'diff',
      'dockerfile', 'go', 'json', 'llvm', 'lua', 'make', 'markdown',
      'ninja', 'python', 'rust', 'rst', 'toml', 'vim', 'yaml' },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = false,
    },
    indent = {
      enable = false,
    }
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end
}
