local treesitter = require('nvim-treesitter')
local function treelocation()
  return treesitter.statusline({
    indicator_size = 70,
    type_patterns = {'class', 'function', 'method'},
    separator = ' 契'
  })
end

require('lualine').setup{
  options = {
    icons_enabled = true,
    padding = 2,
    theme = 'gruvbox_material'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {{'filename', path = 1}, 'diff', {treelocation}},
    lualine_x = {'encoding', 'fileformat'},
    lualine_y = {'progress'},
    lualine_z = {{'diagnostics', sources = {'nvim_lsp'}}}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'location', 'progress'},
    lualine_y = {},
    lualine_z = {}
  }
}
