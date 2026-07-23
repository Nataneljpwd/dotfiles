local add = vim.pack.add

add({ 'https://github.com/scottmckendry/cyberdream.nvim', })

require('cyberdream').setup({ transparent = true, cache = false })

vim.cmd [[colorscheme cyberdream]]
