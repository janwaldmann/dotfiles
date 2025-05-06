return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  init = function()
    require('catppuccin').setup({
      flavour = 'frappe',
      integrations = {
        blink_cmp = true,
        fidget = true,
        fzf = true,
      },
    })
    vim.cmd([[colorscheme catppuccin]])
  end,
}
