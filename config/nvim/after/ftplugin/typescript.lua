--
-- javascript filetype
--

local auGroup = vim.api.nvim_create_augroup('JamAutocmdsJavaScriptFormatting', {})

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format()

    require('typescript').actions.addMissingImports({ sync = true })
    require('typescript').actions.organizeImports({ sync = true })
    -- require('typescript').actions.removeUnused({ sync = true })
    require('typescript').actions.fixAll({ sync = true })

    vim.cmd('silent! EslintFixAll')
  end,
  group = auGroup,
})
