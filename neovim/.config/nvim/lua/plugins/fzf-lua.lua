return {
  'ibhagwan/fzf-lua',
  enabled = true,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find files', noremap = true },
    { '<leader>fr', '<cmd>FzfLua files resume=true<cr>', desc = 'Find files (resume)', noremap = true },
    { '<leader>fg', '<cmd>FzfLua live_grep<cr>', desc = 'Live grep', noremap = true },
    { '<leader>fb', '<cmd>FzfLua buffers<cr>', desc = 'Find buffers', noremap = true },
    { '<leader>fh', '<cmd>FzfLua helptags<cr>', desc = 'Find help tags', noremap = true },
    { '<leader>gf', '<cmd>FzfLua git_files<cr>', desc = 'Find repository files', noremap = true },
  },
  opts = {
    winopts = {
      preview = {
        vertical = 'down:65%', -- up|down:size
        layout = 'vertical', -- horizontal|vertical|flex
      },
    },
  },
}
