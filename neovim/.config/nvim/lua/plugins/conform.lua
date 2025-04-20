return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>fo',
      function()
        require('conform').format({ async = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    -- log_level = vim.log.levels.DEBUG, -- NB: the log is shown in :ConformInfo
    formatters_by_ft = {
      python = { 'isort', 'black' },
      rust = { 'rustfmt' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      bzl = { 'buildifier' },
      sh = { 'shfmt' },
      json = { 'jq' },
      tex = { 'latexindent' },
      lua = { 'stylua' },
      markdown = { 'trim_whitespace', 'trim_newlines' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    -- format_on_save = {
    --   timeout_ms = 500,
    -- },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
