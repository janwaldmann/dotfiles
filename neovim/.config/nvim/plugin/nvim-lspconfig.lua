local nvim_lsp = require('lspconfig')
local custom_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<leader>vD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>vd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>vh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>vi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>vs', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
  vim.keymap.set('n', '<leader>vt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>vr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>sd', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<leader>[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', '<leader>]d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, bufopts)
  vim.keymap.set('n', '<leader>fo', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Lua
local sumneko_root_path = vim.g.sumneko_root_path
local sumneko_binary = sumneko_root_path .. '/bin/lua-language-server'
nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = custom_attach
}

-- Rust
nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
  filetypes = { 'rust' },
  on_attach = custom_attach
}

-- Bash
nvim_lsp.bashls.setup {
  capabilities = capabilities,
  filetypes = { 'sh' },
  on_attach = custom_attach
}

-- C++
nvim_lsp.clangd.setup {
  capabilities = capabilities,
  filetypes = { 'h', 'hpp', 'c', 'cc', 'cpp', 'objc', 'objcpp' },
  on_attach = custom_attach
}

-- Python
nvim_lsp.jedi_language_server.setup {
  capabilities = capabilities,
  on_attach = custom_attach,
  filetypes = { 'python' }
}

nvim_lsp.diagnosticls.setup {
  capabilities = capabilities,
  on_attach = custom_attach,
  filetypes = { 'python' },
  init_options = {
    linters = {
      mypy = {
        sourceName = 'mypy',
        command = 'mypy',
        args = {
          '--no-color-output',
          '--no-error-summary',
          '--show-column-numbers',
          '--follow-imports=silent',
          '%file'
        },
        formatPattern = {
          '^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$',
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4
          }
        },
        rootPatterns = { 'tox.ini', 'setup.cfg', 'mypy.ini', 'setup.py', '.git', 'pyproject.toml' },
        securities = {
          error = 'error'
        }
      },
      flake8 = {
        command = 'flake8',
        debounce = 100,
        args = { '--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s', '-' },
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'flake8',
        formatLines = 1,
        formatPattern = {
          '(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$',
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4
          }
        },
        rootPatterns = { 'tox.ini', 'setup.cfg', 'mypy.ini', 'setup.py', '.git', 'pyproject.toml' },
        securities = {
          W = 'warning',
          E = 'error',
          F = 'error',
          C = 'error',
          N = 'error'
        }
      }
    },
    filetypes = {
      python = { 'mypy', 'flake8' }
    },
    formatters = {
      yapf = {
        command = 'yapf',
        args = { '--quiet' },
        rootPatterns = { 'tox.ini', 'setup.cfg', 'mypy.ini', 'setup.py', '.git', 'pyproject.toml' }
      },
      isort = {
        command = 'isort',
        args = { '--quiet', '-' },
        rootPatterns = { 'tox.ini', 'setup.cfg', 'mypy.ini', 'setup.py', '.git', 'pyproject.toml' }
      }
    },
    formatFiletypes = {
      python = { 'isort', 'yapf' }
    }
  }
}
