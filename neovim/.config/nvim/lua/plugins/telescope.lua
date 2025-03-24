return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    },
  },
  config = function()
    local telescope = require('telescope')
    telescope.setup {
      defaults = {
        file_ignore_patterns = { '.*%.svg' },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        }
      }
    }
    telescope.load_extension('fzf')
    local opts = { noremap = true }
    vim.keymap.set('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<CR>', opts)
    vim.keymap.set('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<CR>', opts)
    vim.keymap.set('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<CR>', opts)
    vim.keymap.set('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<CR>', opts)
    vim.keymap.set('n', '<leader>gs', '<cmd>lua require(\'telescope.builtin\').git_stash()<CR>', opts)
    vim.keymap.set('n', '<leader>gf', '<cmd>lua require(\'telescope.builtin\').git_files()<CR>', opts)
    vim.keymap.set('n', '<leader>gb', '<cmd>lua require(\'telescope.builtin\').git_branches()<CR>', opts)
  end
}
