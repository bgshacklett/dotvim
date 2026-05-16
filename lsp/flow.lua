---@type vim.lsp.Config
return {
  cmd = function(dispatchers)
    local cmd
    if vim.fn.executable('flow') == 1 then
      cmd = { 'flow', 'lsp' }
    else
      cmd = { 'npx', '--no-install', 'flow', 'lsp' }
    end
    return vim.lsp.rpc.start(cmd, dispatchers)
  end,
  filetypes = { 'javascript', 'javascriptreact' },
  root_markers = { '.flowconfig' },
}
