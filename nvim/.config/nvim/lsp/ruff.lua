---@type vim.lsp.Config
return {
  cmd = { 'ruff-lsp' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.git' },
  settings = {},
}
