--
-- init.lua
--
pcall(require, 'impatient')

require('builtin_plugins').disable()
require('plugins').setup()
require('jam')
