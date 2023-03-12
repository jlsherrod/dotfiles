-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	automatic_installation = true,
})
-- mason auto-update
require("mason-tool-installer").setup({
	ensure_installed = {
		"codespell",
		"prettierd",
		"selene",
		"shellcheck", -- used by bash-language-server
		"stylua",
	},
	auto_update = true,
	run_on_start = true,
	start_delay = 5000,
})
