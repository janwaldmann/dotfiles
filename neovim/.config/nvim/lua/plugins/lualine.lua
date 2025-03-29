return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      icons_enabled = true,
      padding = 2,
      theme = 'gruvbox-material'
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { { 'filename', path = 1 }, 'diff' },
      lualine_x = { 'diagnostics', 'encoding' },
      lualine_y = { { 'fileformat', sources = { 'nvim_diagnostic' } } },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'location', 'progress' },
      lualine_y = {},
      lualine_z = {}
    }
  }
}
