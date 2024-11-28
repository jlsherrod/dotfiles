-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- copy to system clipbaord
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y')
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- nvim-tree
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
--no highlight --
vim.keymap.set("n", "<leader>n", "<cmd>noh<cr>", { desc = "UN-highlight search" })
-- Copilot accept suggestion
vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- Copilot Chat open chat window
vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Open Copilot Chat" })
