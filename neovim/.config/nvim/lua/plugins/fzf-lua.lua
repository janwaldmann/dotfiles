return {
  "ibhagwan/fzf-lua",
  enabled = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzflua = require('fzf-lua')
    fzflua.setup({
      winopts = {
        preview = {
          vertical = "down:55%", -- up|down:size
          layout   = "vertical", -- horizontal|vertical|flex
        },
      }
    })
    local opts = { noremap = true }
    vim.keymap.set('n', '<leader>ff', fzflua.files, opts)
    vim.keymap.set('n', '<leader>fg', fzflua.live_grep, opts)
    vim.keymap.set('n', '<leader>fb', fzflua.buffers, opts)
    vim.keymap.set('n', '<leader>fh', fzflua.helptags, opts)
    vim.keymap.set('n', '<leader>gf', fzflua.git_files, opts)
    vim.keymap.set('n', '<leader>fr', fzflua.resume, opts)
  end
}
