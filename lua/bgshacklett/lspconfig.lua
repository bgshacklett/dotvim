-- Diagnostic mappings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader><space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
vim.keymap.set('n', '<leader><space>q', vim.diagnostic.setloclist, opts)

-- Keep the quickfix list in sync with diagnostics. Scheduled so we don't pay
-- on every keystroke when servers stream updates.
do
  local pending = false
  vim.api.nvim_create_autocmd('DiagnosticChanged', {
    callback = function()
      if pending then return end
      pending = true
      vim.schedule(function()
        pending = false
        vim.diagnostic.setqflist({ open = false })
      end)
    end,
  })
end

-- Buffer-local LSP setup runs every time a client attaches.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- Prefer LSP folding if client supports it
    if client:supports_method('textDocument/foldingRange') then
      vim.wo[0][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    local list_workspace_folders = function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end

    local fmt = function()
      vim.lsp.buf.format({ async = true })
    end

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader><space>k', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader><space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader><space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader><space>wl', list_workspace_folders, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader><space>f', fmt, bufopts)
  end,
})

-- Shared capabilities (nvim-cmp adds completion capabilities on top of the
-- defaults). vim.lsp.config('*', ...) merges these into every server.
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
vim.lsp.config('*', { capabilities = capabilities })

-- Mason is set up in init.vim and only manages installation; we enable
-- servers ourselves via vim.lsp.enable below.
-- Each name resolves to ~/.config/nvim/lsp/<name>.lua (loaded automatically
-- by vim.lsp.enable on nvim 0.11+).
vim.lsp.enable({
  'basedpyright',
  'bashls',
  'efm',
  'esbonio',
  'eslint',
  'flow',
  'gopls',
  'groovyls',
  'hls',
  'html',
  'jdtls',
  'lua_ls',
  'phpactor',
  'powershell_es',
  'solargraph',
  'taplo',
  'terraformls',
  'tflint',
  'ts_ls',
  'vimls',
  'yamlls',
})

-- Rust is configured via rustaceanvim (see init.vim), which manages
-- rust_analyzer itself. We only need to feed it the shared capabilities and
-- let LspAttach handle keymaps.
vim.g.rustaceanvim = {
  server = {
    capabilities = capabilities,
  },
}
