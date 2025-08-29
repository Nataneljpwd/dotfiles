MiniDeps = require('mini.deps')

local add = MiniDeps.add

add({ source = 'nvim-mini/mini.pick' })

local win_config = function()
    local height = math.floor(0.618 * vim.o.lines)
    local width = math.floor(0.618 * vim.o.columns)
    return {
      anchor = 'NW', height = height, width = width,
      row = math.floor(0.5 * (vim.o.lines - height)),
      col = math.floor(0.5 * (vim.o.columns - width)),
      border = 'double',
    }
end

require('mini.pick').setup({window = {config = win_config}})

vim.keymap.set('n', '<leader>e', ':Pick files tool="git"<CR>')
vim.keymap.set('n', '<leader>sf', ':Pick files tool="rg"<CR>')
vim.keymap.set('n', '<leader>st', ':Pick grep_live<CR>')
