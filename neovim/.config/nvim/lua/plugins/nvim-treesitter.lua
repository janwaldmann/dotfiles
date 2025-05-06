return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'cmake',
      'cpp',
      'diff',
      'dockerfile',
      'go',
      'json',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'ninja',
      'python',
      'rust',
      'rst',
      'toml',
      'vim',
      'vimdoc',
      'yaml',
      'starlark',
      'proto',
      'groovy',
    },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = false,
    },
    indent = {
      enable = false,
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
