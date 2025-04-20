return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'LspInfo', 'LspStart', 'LspStop', 'LspRestart', 'LspLog' },
  dependencies = { 'saghen/blink.cmp', { 'j-hui/fidget.nvim', opts = {} } },
  opts = {
    servers = {
      lua_ls = {},
      rust_analyzer = {},
      bashls = {},
      clangd = {
        cmd = {
          'clangd',
          '--clang-tidy',
          '--background-index',
          '--header-insertion=iwyu',
          '--log=error',
          '-j=4',
        },
      },
      jedi_language_server = {},
    },
  },
  config = function(_, opts)
    for server, config in pairs(opts.servers) do
      vim.lsp.enable(server)
      vim.lsp.config(server, config)
    end

    vim.lsp.config('*', {
      capabilities = require('blink.cmp').get_lsp_capabilities(),
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- For default mappings see :help lsp-defaults
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        vim.keymap.set('n', '<leader>vD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', '<leader>vd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', '<leader>vh', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>vi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<leader>vs', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<leader>vt', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>vr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<leader>sd', vim.diagnostic.open_float, bufopts)
        vim.keymap.set('n', '<leader>[d', function()
          vim.diagnostic.jump({ count = 1, float = true, wrap = false })
        end, bufopts)
        vim.keymap.set('n', '<leader>]d', function()
          vim.diagnostic.jump({ count = -1, float = true, wrap = false })
        end, bufopts)
        vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, bufopts)
      end,
    })
  end,
}
