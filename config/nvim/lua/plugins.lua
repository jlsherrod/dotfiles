local M = {}

function M.setup()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	-- Install package manager
	--    https://github.com/folke/lazy.nvim
	--    `:help lazy.nvim.txt` for more info
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)

	-- NOTE: Here is where you install your plugins.
	--  You can configure plugins using the `config` key.
	--
	--  You can also configure plugins after the setup call,
	--    as they will be available in your neovim runtime.
	require("lazy").setup({
		-- NOTE: First, some plugins that don't require any configuration
		--add autopairs
		"windwp/nvim-autopairs",
		-- Git related plugins
		"tpope/vim-fugitive",
		"tpope/vim-rhubarb",
		-- Alpha-nvim - greeter screen
		"goolord/alpha-nvim",
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
		-- Tmux navigator for use with toggleterm.nvim
		"christoomey/vim-tmux-navigator",
		-- Obsidian plugin for neovim
		{
			"epwalsh/obsidian.nvim",
			version = "*", -- recommended, use latest release instead of latest commit
			lazy = false,
			dependencies = {
				-- Required.
				"nvim-lua/plenary.nvim",
			},
			opts = {
				workspaces = {
					{
						name = "Main",
						path = "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Main",
					},
				},
				templates = {
					subdir = "Templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M:%S",
				},
				completion = {
					nvim_cmp = true,
					min_chars = 2,
				},
				ui = {
					-- Disable some things below here because I set these manually for all Markdown files using treesitter
					enable = false,
					checkboxes = {},
					bullets = {},
				},
			},
		},

		-- Toggleterm for terminal access in editor window
		{ "akinsho/toggleterm.nvim", version = "*", config = true },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Github Copilot
		{
			"zbirenbaum/copilot.lua",
			opts = {
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<Tab>",
					},
				},
			},
		},
		-- Copilot Chat
		{
			"CopilotC-Nvim/CopilotChat.nvim",
			branch = "main",
			dependencies = {
				{ "github/copilot.vim" },
				{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
			},
			build = "make tiktoken", -- Only on MacOS or Linux
			opts = {
				panel = {
					border = "rounded", -- Customize border appearance
					position = "right", -- Change position of the chat panel
					width = 50, -- Adjust width of the panel
				},
				keymaps = {
					toggle_chat = "<leader>cc", -- Hotkey to toggle Copilot chat
					send_message = "<leader>cm", -- Hotkey to send a message
				},
			},
			-- See Configuration section for options
		},
		-- See Commands section for default commands if you want to lazy load on them
		-- NOTE: This is where your plugins related to LSP can be installed.
		--  The configuration is done below. Search for lspconfig to find it below.
		{ -- LSP Configuration & Plugins
			"neovim/nvim-lspconfig",
			dependencies = {
				-- Automatically install LSPs to stdpath for neovim
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				{
					"pmizio/typescript-tools.nvim",
					dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
					opts = {},
				},
				-- Useful status updates for:			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
				{ "j-hui/fidget.nvim", opts = {} },

				-- Additional lua configuration, makes nvim stuff amazing!
				"folke/neodev.nvim",
			},
		},
		-- Optimize vim load times with impatient
		"lewis6991/impatient.nvim",
		{ -- break out luasnip
			"L3MON4D3/LuaSnip",
		},
		{
			"wassimk/scalpel.nvim",
			version = "*",
			config = true,
			keys = {
				{
					"<leader>e",
					function()
						require("scalpel").substitute()
					end,
					mode = { "n", "x" },
					desc = "substitute word(s)",
				},
			},
		},
		-- {
		-- 	"wassimk/gh-navigator.nvim",
		-- 	version = "*",
		-- 	config = true,
		-- 	dev = true,
		-- },
		{ -- Autocompletion
			"hrsh7th/nvim-cmp",
			dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
		},

		-- Useful plugin to show you pending keybinds.
		{ "folke/which-key.nvim", opts = {} },
		{ -- Adds git related signs to the gutter, as well as utilities for managing changes
			"lewis6991/gitsigns.nvim",
			opts = {
				-- See `:help gitsigns.txt`
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			},
		},

		{ -- Theme inspired by Atom
			"navarasu/onedark.nvim",
			priority = 1000,
			config = function()
				vim.cmd.colorscheme("onedark")
			end,
		},
		{ -- Set lualine as statusline
			"nvim-lualine/lualine.nvim",
		},

		{ -- Add indentation guides even on blank lines
			"lukas-reineke/indent-blankline.nvim",
			event = "VeryLazy",
			version = "*",
			main = "ibl",
			config = true,
		},

		-- "gc" to comment visual regions/lines
		{ "numToStr/Comment.nvim", opts = {} },

		-- Fuzzy Finder (files, lsp, etc)
		{ "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } },

		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
					},
				},
			})
		end,

		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},

		{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

		{ -- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			dependencies = {
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			config = function()
				pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			end,
		},
		{ "jose-elias-alvarez/null-ls.nvim" },
		{
			"roobert/tailwindcss-colorizer-cmp.nvim",
			-- optionally, override the default options:
			config = function()
				require("tailwindcss-colorizer-cmp").setup({
					color_square_width = 2,
				})
			end,
		},
	}, {
		dev = { path = "~/Projects/neovim" },
	})
end

return M
