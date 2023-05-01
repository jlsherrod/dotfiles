local lspconfig = require('lspconfig')

lspconfig.emmet_ls.setup({
  on_attach = require('jam.lsp').on_attach,
  capabilities = require('jam.lsp').capabilities(),
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ['bem.enabled'] = true,
      },
    },
  },
})
