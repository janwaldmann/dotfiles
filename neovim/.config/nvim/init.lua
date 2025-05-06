-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Local leader
vim.g.maplocalleader = ','

-- Leader
vim.keymap.set('n', ',', '', { noremap = true })
vim.g.mapleader = ','
vim.keymap.set('n', '\\', ',', { noremap = true })

-- Unmap normal mode C-a (my tmux prefix)
vim.keymap.set('n', '<C-a>', '<Nop>', { noremap = true })

require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'catppuccin' } },
  checker = { enabled = false },
})
