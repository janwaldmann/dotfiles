return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    },
    'nvim-telescope/telescope-smart-history.nvim',
    'kkharji/sqlite.lua'
  },
  config = function()
    local telescope = require('telescope')
    local telescope_actions = require('telescope.actions')
    local datapath = vim.fn.stdpath('data')
    telescope.setup {
      defaults = {
        file_ignore_patterns = { '.*%.svg' },
        history = {
          ---@diagnostic disable-next-line: param-type-mismatch
          path = vim.fs.joinpath(datapath, 'telescope_history.sqlite3'),
          limit = 60
        },
        mappings = {
          i = {
            ['<C-Down>'] = telescope_actions.cycle_history_next,
            ['<C-Up>'] = telescope_actions.cycle_history_prev,
          }
        }
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
    telescope.load_extension('smart_history')
    local opts = { noremap = true }
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
    vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
    vim.keymap.set('n', '<leader>gf', builtin.git_files, opts)
  end
}
