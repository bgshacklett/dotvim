-- File explorer: Fern as a toggleable drawer with git status decorations.
--
-- This module owns its own plugins, including dependencies.

vim.pack.add({
  "https://github.com/lambdalisue/fern.vim",             -- tree explorer
  "https://github.com/lambdalisue/fern-git-status.vim",  -- git status badges in the tree
})

-- Toggle the drawer, revealing the current file, then equalise window sizes.
vim.keymap.set("n", "<C-f>", ":Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=", {
  silent = true,
  desc = "Fern: toggle file drawer",
})
