-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- copy to system clipbaord
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y')
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- tmux mappings to match neovim
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })

-- nvim-tree
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
--no highlight --
vim.keymap.set("n", "<leader>N", "<cmd>noh<cr>", { desc = "UN-highlight search" })
-- Copilot accept suggestion
vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- Copilot Chat open chat window
vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Open Copilot Chat" })
-- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>vn", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")
-- navigate to vault
vim.keymap.set("n", "<leader>vv", ":cd /Users/jimjam/library/Mobile Documents/iCloud~md~obsidian/Documents/Main<cr>")
-- strip date from note title and replace dashes with spaces
-- must have cursor on title
vim.keymap.set("n", "<leader>vf", ":s/\\d\\d\\d\\d-\\d\\d-\\d\\d// | s/-/ /g<cr>")
-- for review workflow
-- move file in current buffer to zettelkasten folder
vim.keymap.set(
	"n",
	"<leader>vk",
	":!mv '%:p' /Users/jimjam/library/Mobile Documents/iCloud~md~obsidian/Documents/Main/zettelkasten<cr>:bd<cr>"
)
-- delete file in current buffer
vim.keymap.set("n", "<leader>vdd", ":!rm '%:p'<cr>:bd<cr>")
