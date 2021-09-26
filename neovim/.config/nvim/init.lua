-- Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end
require('plugins')

-- Path to lua-language-server
vim.g.sumneko_root_path = '/home/jan/Dev/lua-language-server'

-- Theme specific settings
vim.o.background = 'dark'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_background = 'medium'
vim.cmd 'colorscheme gruvbox-material'

-- LuaSnip(pets)
require('snippets')

-- Leader
vim.api.nvim_set_keymap('n', ',', '', {noremap = true})
vim.g.mapleader = ','
vim.api.nvim_set_keymap('n', [[\]], ',', {noremap = true})
