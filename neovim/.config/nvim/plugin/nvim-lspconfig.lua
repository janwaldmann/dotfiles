local nvim_lsp = require('lspconfig')
local custom_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Keymaps
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', '<leader>vD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>vd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>vh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>vi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>vs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>vt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>vr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>sd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>]d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', '<leader>fo', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Lua
local system_name
if vim.fn.has('mac') == 1 then
  system_name = 'macOS'
elseif vim.fn.has('unix') == 1 then
  system_name = 'Linux'
elseif vim.fn.has('win32') == 1 then
  system_name = 'Windows'
else
  print('lua-language-server: could not determine host OS')
end
local sumneko_root_path = vim.g.sumneko_root_path
local sumneko_binary = sumneko_root_path..'/bin/'..system_name..'/lua-language-server'
nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
  filetypes = {'lua'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = custom_attach
}

-- Rust
nvim_lsp.rust_analyzer.setup{
  capabilities = capabilities,
  filetypes = {'rust'},
  on_attach = custom_attach
}

-- Bash
nvim_lsp.bashls.setup{
  capabilities = capabilities,
  filetypes = {'sh'},
  on_attach = custom_attach
}

-- C++
nvim_lsp.clangd.setup{
  capabilities = capabilities,
  filetypes = {'c', 'cc', 'cpp', 'objc', 'objcpp'},
  on_attach = custom_attach
}

-- Python
nvim_lsp.jedi_language_server.setup{
  capabilities = capabilities,
  on_attach = custom_attach,
  filetypes = {'python'}
}

nvim_lsp.diagnosticls.setup {
  capabilities = capabilities,
  on_attach = custom_attach,
  filetypes = {'python'},
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
        rootPatterns = {'tox.ini', 'setup.cfg', 'mypy.ini', 'setup.py', '.git', 'pyproject.toml'},
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
        rootPatterns = {'tox.ini', 'setup.cfg', 'mypy.ini', 'setup.py', '.git', 'pyproject.toml'},
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
      python = {'mypy', 'flake8'}
    },
    formatters = {
      yapf = {
        command = 'yapf',
        args = {'--quiet'},
        rootPatterns = {'tox.ini', 'setup.cfg', 'mypy.ini', 'setup.py', '.git', 'pyproject.toml'}
      },
      isort = {
        command = 'isort',
        args = {'--quiet', '-'},
        rootPatterns = {'tox.ini', 'setup.cfg', 'mypy.ini', 'setup.py', '.git', 'pyproject.toml'}
      }
    },
    formatFiletypes = {
      python = {'isort', 'yapf'}
    }
  }
}
