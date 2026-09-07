-- UI: colorscheme, statusline, and appearance settings that belong to them.
--
-- This module owns its own plugins, including dependencies.

vim.pack.add({
  "https://github.com/rakr/vim-one",                 -- colorscheme (light and dark)
  "https://github.com/NLKNguyen/papercolor-theme",   -- alternate colorscheme
  "https://github.com/nvim-lualine/lualine.nvim",    -- statusline
  "https://github.com/nvim-tree/nvim-web-devicons",  -- icons for lualine
})

vim.o.termguicolors = true

-- Neovim detects light/dark from the terminal at startup (OSC 11 query) and
-- vim-one follows 'background'. Terminals that don't answer the query (older
-- Windows Terminal, tmux) leave Neovim guessing dark; set NVIM_BACKGROUND to
-- light or dark in that terminal's profile to override.
if vim.env.NVIM_BACKGROUND then
  vim.o.background = vim.env.NVIM_BACKGROUND
end

vim.cmd("colorscheme one")
vim.cmd("highlight ColorColumn guibg=#444444")

require("lualine").setup({})
