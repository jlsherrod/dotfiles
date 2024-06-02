-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>t", vim.diagnostic.open_float, { desc = "DIAGNOSTICS: open float" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
