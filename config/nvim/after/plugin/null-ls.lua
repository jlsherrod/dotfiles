--
-- null-ls.nvim
-- https://github.com/jose-elias-alvarez/null-ls.nvim
--

local null_ls = require('null-ls')

local sources = {
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.prettierd,
  null_ls.builtins.diagnostics.codespell,
  null_ls.builtins.code_actions.shellcheck,
}

null_ls.setup({ sources = sources, on_attach = require('jam.lsp').on_attach })
