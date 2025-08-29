MiniDeps = require('mini.deps')

local add = MiniDeps.add

add({source = 'scottmckendry/cyberdream.nvim'})

require('cyberdream').setup({transparent=true, cache=true})

vim.cmd[[colorscheme cyberdream]]
