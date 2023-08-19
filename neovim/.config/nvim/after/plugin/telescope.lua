require 'telescope'.setup {
  defaults = {
    file_ignore_patterns = { ".*%.svg" },
  },
  extensions = {
    frecency = {
      ignore_patterns = { "*.git/*", "*/tmp/*", "*/__pycache__/*" },
      workspaces = {
        ["config"] = vim.fn.expand("~/.config"),
        ["nvimconfig"] = vim.fn.expand("~/.config/nvim")
      }
    }
  },
}

require 'telescope'.load_extension('frecency')

local opts = { noremap = true }
vim.keymap.set('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<CR>', opts)
vim.keymap.set('n', '<leader>fc', '<cmd>lua require(\'telescope\').extensions.frecency.frecency()<CR>', opts)
vim.keymap.set('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<CR>', opts)
vim.keymap.set('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<CR>', opts)
vim.keymap.set('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<CR>', opts)
vim.keymap.set('n', '<leader>gs', '<cmd>lua require(\'telescope.builtin\').git_stash()<CR>', opts)
vim.keymap.set('n', '<leader>gf', '<cmd>lua require(\'telescope.builtin\').git_files()<CR>', opts)
vim.keymap.set('n', '<leader>gb', '<cmd>lua require(\'telescope.builtin\').git_branches()<CR>', opts)
