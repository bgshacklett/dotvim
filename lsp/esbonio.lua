---@type vim.lsp.Config
return {
  cmd = { 'python3', '-m', 'esbonio.server' },
  filetypes = { 'rst' },
  root_markers = { '.git' },
  init_options = {
    server = {
      logLevel = 'debug',
    },
  },
}
