local lspconfig = require("lspconfig")

lspconfig.tailwindcss.setup({
	on_attach = require("jam.lsp").on_attach,
	capabilities = require("jam.lsp").capabilities(),
})
