require'telescope'.setup {
  extensions = {
    frecency = {
      ignore_patterns = {"*.git/*", "*/tmp/*", "*/__pycache__/*"},
      workspaces = {
        ["config"] = vim.fn.expand("~/.config"),
        ["nvimconfig"] = vim.fn.expand("~/.config/nvim")
      }
    }
  }
}

require'telescope'.load_extension('frecency')

local opts = { noremap = true }
local map = vim.api.nvim_set_keymap
map('n','<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<CR>', opts)
map('n','<leader>fc', '<cmd>lua require(\'telescope\').extensions.frecency.frecency()<CR>', opts)
map('n','<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<CR>', opts)
map('n','<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<CR>', opts)
map('n','<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<CR>', opts)
map('n','<leader>gs', '<cmd>lua require(\'telescope.builtin\').git_status()<CR>', opts)
map('n','<leader>gf', '<cmd>lua require(\'telescope.builtin\').git_files()<CR>', opts)
map('n','<leader>gb', '<cmd>lua require(\'telescope.builtin\').git_branches()<CR>', opts)
