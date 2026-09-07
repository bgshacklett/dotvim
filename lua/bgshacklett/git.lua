-- Git: fugitive and friends for commands, gitsigns for gutter signs and hunks.
--
-- This module owns its own plugins, including dependencies.

vim.pack.add({
  "https://github.com/tpope/vim-fugitive",                  -- :Git and everything under it
  "https://github.com/tpope/vim-rhubarb",                   -- GitHub support for :GBrowse
  "https://github.com/borissov/fugitive-bitbucketserver",   -- Bitbucket Server support for :GBrowse
  "https://github.com/rbong/vim-flog",                      -- branch graph viewer
  "https://github.com/lewis6991/gitsigns.nvim",             -- gutter signs, hunk actions
})

-- Hosts that :GBrowse should treat as Bitbucket Server.
vim.g.fugitive_bitbucketservers_domains = { "http://tnc.bitbucket.org" }

require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = "Gitsigns: " .. desc })
    end

    map("<leader>hs", gs.stage_hunk, "stage hunk")
    map("<leader>hu", gs.undo_stage_hunk, "undo stage hunk")
    map("<leader>hp", gs.preview_hunk, "preview hunk")
  end,
})
