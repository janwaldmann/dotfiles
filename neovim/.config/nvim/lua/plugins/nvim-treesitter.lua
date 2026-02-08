return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = function(_)
    require('nvim-treesitter')
      .install({
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
      }, { force = true, summary = true })
      :wait(300000)
  end,
}
