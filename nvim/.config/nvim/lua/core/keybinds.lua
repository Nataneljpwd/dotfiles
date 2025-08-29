vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>h', ':noh<CR>')

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- window controls
vim.keymap.set('n', '<C-J>', '<C-W>j')
vim.keymap.set('n', '<C-H>', '<C-W>h')
vim.keymap.set('n', '<C-K>', '<C-W>k')
vim.keymap.set('n', '<C-L>', '<C-W>l')

vim.keymap.set('n', '<C-Q>', '<C-W>c')

vim.keymap.set('n', '<C-S>', ':split<CR>')


