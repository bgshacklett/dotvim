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



-- -- Set configuration for specific filetype.
--   cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--       { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--     }, {
--       { name = 'buffer' },
--     })
--   })

--   -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
--   cmp.setup.cmdline('/', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--       { name = 'buffer' }
--     }
--   })

--   -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--   cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--       { name = 'path' }
--     }, {
--       { name = 'cmdline' }
--     })
--   })


-- cmp.setup({
--   window = {
--     completion = {
--       border = 'rounded',
--       winhighlight = 'CursorLine:Visual,Search:None',
--       zindex = 1001,
--       col_offset = -3,
--       side_padding = 0,
--     },
--     documentation = {
--       border = 'rounded',
--       winhighlight = 'CursorLine:Visual,Search:None',
--       zindex = 1001,
--       col_offset = 10,
--       side_padding = 1,
--     },
--   },
--   formatting = {
--     fields = { cmp.ItemField.Kind, cmp.ItemField.Abbr, cmp.ItemField.Menu },
--     format = function(entry, vim_item)
--       local kind = lspkind.cmp_format({
--         mode = 'symbol_text',
--         maxwidth = 50,
--         menu = {
--           nvim_lsp = 'lsp',
--           luasnip = 'luasnip',
--           buffer = 'buffer',
--           nvim_lua = 'lua',
--         },
--       })(entry, vim_item)

--       local strings = vim.split(kind.kind, '%s', { trimempty = true })
--       kind.kind = ' ' .. strings[1] .. ' '
--       local menu = kind.menu
--       kind.menu = ' ' .. strings[2]
--       if menu then
--         kind.menu = kind.menu .. ' ' .. menu
--       end

--       return kind
--     end,
--   },
--   enabled = function()
--     -- disable completion in prompts such as telescope filtering prompt
--     local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
--     if buftype == 'prompt' then
--       return false
--     end

--     -- disable completion in comments
--     local context = require('cmp.config.context')
--     if context.in_treesitter_capture('comment') or context.in_syntax_group('Comment') then
--       return false
--     end

--     return true
--   end,
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   preselect = cmp.PreselectMode.None,
--   mapping = {
--     ['<C-n>'] = cmp.mapping(select_next_item, { 'i', 's' }),
--     ['<C-p>'] = cmp.mapping(select_prev_item, { 'i', 's' }),
--     ['<Tab>'] = cmp.mapping(select_next_item, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(select_prev_item, { 'i', 's' }),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<CR>'] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = false,
--     }),
--   },
--   sorting = {
--     comparators = {
--       lspkind_comparator({
--         kind_priority = {
--           Variable = 12,
--           Field = 11,
--           Property = 11,
--           Constant = 10,
--           Enum = 10,
--           EnumMember = 10,
--           Event = 10,
--           Function = 10,
--           Method = 10,
--           Operator = 10,
--           Reference = 10,
--           Struct = 10,
--           Module = 9,
--           File = 8,
--           Folder = 8,
--           Class = 5,
--           Color = 5,
--           Keyword = 2,
--           Constructor = 1,
--           Interface = 1,
--           Text = 1,
--           TypeParameter = 1,
--           Unit = 1,
--           Value = 1,
--           Snippet = 0,
--         },
--       }),
--       label_comparator,
--     },
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'nvim_lsp_signature_help' },
--     { name = 'luasnip' },
--     { name = 'nvim_lua' },
--   }, {
--     { name = 'buffer' },
--   }, {
--     { name = 'path' },
--   }),
-- })

-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'git' },
--   }, {
--     { name = 'buffer' },
--   }),
-- })

-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' },
--   },
-- })

-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' },
--   }, {
--     { name = 'cmdline' },
--   }),
-- })
