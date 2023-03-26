--
-- lualine.nvim
-- https://github.com/nvim-lualine/lualine.nvim
--

local has_lualine, lualine = pcall(require, 'lualine')

if not has_lualine then
  return
end

lualine.setup({
  options = {
    globalstatus = true,
  },
  icons_enabled = true,
  theme = 'onedark',
  component_separators = '|',
  section_separators = '',
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {},
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {
    'toggleterm',
    'quickfix',
    'nvim-tree',
  },
})
