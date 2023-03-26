require('neodev').setup()

require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      -- https://github.com/LuaLS/lua-language-server/wiki/Settings
      completion = { enable = true, showWord = 'Disable' },
      diagnostics = { globals = { 'vim', 'hs', 'packer_plugins' } },
      format = { enable = false },
      runtime = { version = 'LuaJIT' },
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
    },
  },
  capabilities = require('jam.lsp').capabilities(),
  on_attach = require('jam.lsp').on_attach,
})
