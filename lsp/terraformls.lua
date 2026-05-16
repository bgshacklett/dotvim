---@type vim.lsp.Config
return {
  cmd = {
    'terraform-ls', 'serve',
    '-log-file=' .. vim.env.HOME .. '/tmp/terraform-ls.log',
  },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform', '.git' },
}
