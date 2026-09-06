---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.emmyrc.json',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      -- workspace.library is managed by lazydev.nvim (see
      -- lua/bgshacklett/lspconfig.lua), which adds only the runtime and the
      -- plugins a file actually requires.
      telemetry = {
        enable = false,
      },
    },
  },
}
