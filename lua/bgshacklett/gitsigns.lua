local gitsigns = require('gitsigns')

local M = {}

function M.setup()
  gitsigns.setup({
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map('<leader>hs', gs.stage_hunk, 'Gitsigns: stage hunk')
      map('<leader>hu', gs.undo_stage_hunk, 'Gitsigns: undo stage hunk')
      map('<leader>hp', gs.preview_hunk, 'Gitsigns: preview hunk')
    end,
  })
end

return M

