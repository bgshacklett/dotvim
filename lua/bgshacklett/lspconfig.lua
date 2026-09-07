-- LSP: built-in vim.lsp.config/enable with per-server configs under
-- ~/.config/nvim/lsp/<name>.lua. Servers are installed by mason (see
-- mason.lua, required before this module); enabling is done here.
--
-- This module owns its own plugins, including dependencies.

vim.pack.add({
  "https://github.com/folke/lazydev.nvim",        -- lua_ls workspace for Neovim config
  "https://github.com/mfussenegger/nvim-jdtls",   -- Java (eclipse.jdt.ls)
  "https://github.com/mrcjkb/rustaceanvim",       -- Rust (manages rust-analyzer itself)
})

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

-- Fold expression that keeps a fold's opening line visible. Servers such as
-- gopls start their folding range on the `import (` / `func x() {` line, and
-- Vim always hides a fold's first line behind the fold text. Shifting the
-- start down one line leaves the header on screen for context.
function _G.lsp_context_foldexpr(lnum)
  local v = vim.lsp.foldexpr(lnum)
  if v:sub(1, 1) == '>' then
    return tostring(tonumber(v:sub(2)) - 1)
  end
  return v
end

-- When the LSP fold ranges are recomputed, a fold that did not exist before
-- (e.g. a block just completed with `}`) is created closed if it is deeper
-- than 'foldlevel', even when the cursor is inside it. Re-open just enough to
-- expose the cursor line afterwards so a rebuild never closes a fold on top of
-- the cursor. Sibling folds and folds elsewhere are left as they are.
--
-- The rebuild runs in the foldingRange response handler in normal mode, and
-- is deferred to InsertLeave while in insert mode, so both are hooked.
local function reveal_cursor()
  if vim.api.nvim_get_mode().mode:match('^i') then return end
  if vim.wo.foldenable and vim.wo.foldmethod == 'expr' then
    vim.cmd('silent! normal! zv')
  end
end

vim.api.nvim_create_autocmd('LspRequest', {
  callback = function(args)
    local req = args.data.request
    if req.type == 'complete' and req.method == 'textDocument/foldingRange' then
      vim.schedule(reveal_cursor)
    end
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function() vim.schedule(reveal_cursor) end,
})

-- Buffer-local LSP setup runs every time a client attaches.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- Prefer LSP folding if client supports it
    if client:supports_method('textDocument/foldingRange') then
      vim.wo[0][0].foldexpr = 'v:lua.lsp_context_foldexpr()'
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

-- lazydev feeds lua_ls a workspace library of just the Neovim runtime plus
-- the plugins a Lua file actually requires, instead of the whole runtimepath.
-- Set up after vim.lsp.enable so its root-dir integration sees lua_ls.
require("lazydev").setup({
  library = {
    -- luv types, only when a file mentions vim.uv
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

-- Rust is configured via rustaceanvim, which manages
-- rust_analyzer itself. We only need to feed it the shared capabilities and
-- let LspAttach handle keymaps.
vim.g.rustaceanvim = {
  server = {
    capabilities = capabilities,
  },
}
