-- Completion and snippets: nvim-cmp with UltiSnips as the snippet engine.
--
-- This module owns its own plugins, including dependencies.

vim.pack.add({
  "https://github.com/hrsh7th/nvim-cmp",                     -- completion engine
  "https://github.com/hrsh7th/cmp-nvim-lsp",                 -- LSP source
  "https://github.com/hrsh7th/cmp-buffer",                   -- buffer words source
  "https://github.com/hrsh7th/cmp-path",                     -- filesystem path source
  "https://github.com/hrsh7th/cmp-cmdline",                  -- command-line source
  "https://github.com/SirVer/ultisnips",                     -- snippet engine
  "https://github.com/quangnguyen30192/cmp-nvim-ultisnips",  -- UltiSnips source for cmp
  "https://github.com/honza/vim-snippets",                   -- snippet collection
})

vim.o.completeopt = "menu,menuone,noselect"

-- UltiSnips remote debugging. When the debug server is enabled and a snippet
-- raises or hits a breakpoint, a Pdb server starts on the host/port below and
-- can be reached with telnet. PMDebugBlocking controls whether Vim freezes
-- until the debug session ends (1) or keeps running and prints the connection
-- details (0). See :help UltiSnips-debugging.
vim.g.UltiSnipsDebugServerEnable = 0
vim.g.UltiSnipsDebugHost = "localhost"
vim.g.UltiSnipsDebugPort = 8080
vim.g.UltiSnipsPMDebugBlocking = 0

local cmp = require'cmp'
local cmp_ultisnips_mappings = require'cmp_nvim_ultisnips.mappings'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) 
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    else
      cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    end
    end, { 'i', 's' }),
    ['<S-tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      cmp_ultisnips_mappings.jump_backwards(fallback)
    end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'ultisnips' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 5},
  }),
})


local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  preselect = cmp.PreselectMode.None,
--   mapping = {
--     ['<CR>'] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = false,
--     }),
--   },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-n>'] = cmp.mapping.select_next_item(), -- , { 'i', 's' }),
    ['<C-p>'] = cmp.mapping.select_prev_item(), -- , { 'i', 's' }),
    ['<Tab>'] = cmp.mapping.select_next_item(), -- , { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(), -- , { 'i', 's' }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})
