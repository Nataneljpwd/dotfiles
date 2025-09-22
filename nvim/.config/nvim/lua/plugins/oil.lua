MiniDeps = require('mini.deps')

local add = MiniDeps.add

add({ source = 'stevearc/oil.nvim' })

require('oil').setup()

vim.keymap.set('n', '<leader>bf', '<CMD>Oil --float<CR>', {desc='Open file browser in floating window'})

