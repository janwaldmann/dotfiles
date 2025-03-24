return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  init = function()
    vim.o.background = 'dark'
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
    vim.g.gruvbox_material_background = 'medium'
    vim.cmd([[colorscheme gruvbox-material]])
  end
}
