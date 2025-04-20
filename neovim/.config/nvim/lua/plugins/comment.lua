return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts  = {
    mappings = {
      basic = true, -- gcc, gbc, gc[motion], gb[motion]
      extra = true, -- gco, gcO, gcA
    },
  },
}
