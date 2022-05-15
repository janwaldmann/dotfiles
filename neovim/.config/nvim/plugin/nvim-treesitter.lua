require'nvim-treesitter.configs'.setup {
  ensure_installed = {'bash', 'c', 'cmake', 'cpp', 'cuda', 'go', 'json',
                      'llvm', 'lua', 'make', 'markdown', 'ninja', 'python',
                      'rust', 'rst', 'toml', 'vim', 'yaml'},
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = false,
  },
  indent = {
    enable = false,
  },
}
