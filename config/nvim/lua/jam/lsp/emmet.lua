local lspconfig = require("lspconfig")

lspconfig.emmet_language_server.setup({
	on_attach = require("jam.lsp").on_attach,
	capabilities = require("jam.lsp").capabilities(),
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
})
