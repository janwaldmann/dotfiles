-- Local leader
vim.g.maplocalleader = ','

-- Packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd 'packadd packer.nvim'
end
require('plugins')

-- Theme specific settings
vim.o.background = 'dark'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_background = 'medium'
vim.cmd 'colorscheme gruvbox-material'

-- LuaSnip(pets)
require('snippets')

-- Leader
vim.keymap.set('n', ',', '', { noremap = true })
vim.g.mapleader = ','
vim.keymap.set('n', '\\', ',', { noremap = true })

-- vimtex
vim.g.vimtex_preview_method = 'evince'
