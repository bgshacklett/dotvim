-- Configure Leader
vim.g.mapleader = ","

-- Zero-config plugins. Anything that needs setup, options, or keymaps lives
-- in its own module under lua/bgshacklett/ and is required further down.
vim.pack.add({
  -- Preview Tools
  "https://github.com/shime/vim-livedown",

  -- Syntax ranges and regions
  "https://github.com/vim-scripts/SyntaxRange",
  "https://github.com/chrisbra/NrrwRgn",

  -- Language Enhancements
  "https://github.com/elzr/vim-json",
  "https://github.com/rodjek/vim-puppet",
  "https://github.com/PProvost/vim-ps1",
  "https://github.com/Rykka/InstantRst",
  "https://github.com/pedrohdz/vim-yaml-folds",
  "https://github.com/epcim/vim-chef",
  "https://github.com/vito-c/jq.vim",
  "https://github.com/hashivim/vim-vagrant",
  "https://github.com/hashivim/vim-packer",
  "https://github.com/towolf/vim-helm",
  "https://github.com/Glench/Vim-Jinja2-Syntax",
  -- Python
  "https://github.com/vim-python/python-syntax",
  "https://github.com/Vimjas/vim-python-pep8-indent",

  -- Terminal/Environment Integrations
  "https://github.com/bgshacklett/vitality.vim",

  "https://github.com/powerman/vim-plugin-AnsiEsc",

  -- Feature Enhancements
  "https://github.com/Yggdroot/indentLine", -- No longer maintained
  "https://github.com/tmhedberg/SimpylFold",
  -- "https://github.com/Konfekt/FastFold",
  "https://github.com/wfaulk/iRuler.vim",

  -- General Syntax
  "https://github.com/sheerun/vim-polyglot",

  -- Helpers
  "https://github.com/tpope/vim-unimpaired",
  "https://github.com/gregsexton/MatchTag",
  "https://github.com/godlygeek/tabular",
  "https://github.com/bkad/CamelCaseMotion",
  "https://github.com/tpope/vim-dispatch",
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-repeat",
  "https://github.com/sagarrakshe/toggle-bool",
  "https://github.com/tpope/vim-commentary",
})

-- Completion and snippets (nvim-cmp, UltiSnips)
require('bgshacklett.completion')

-- Git (fugitive, gitsigns)
require('bgshacklett.git')

-- File explorer (Fern)
require('bgshacklett.explorer')


-- Mac specific configs
if vim.fn.has('mac') == 1 then
  -- Configure automatic cursor shape for Insert and Normal Modes
  vim.opt.guicursor = {
    "n-v-c:block",
    "i-ci-ve:ver25",
  }
  -- Set the shell to `sh` for posix compatibility
  vim.opt.shell="sh"
end

-- Syntax Highlighting
vim.g.python_highlight_all = 1
vim.g.markdown_syntax_conceal = 0  -- Don't conceal characters; it's annoying.

-- Configure indentation
vim.opt.expandtab=true
vim.opt.shiftwidth=2
vim.opt.tabstop=2
vim.opt.softtabstop=2

-- Configure Folding
vim.keymap.set({'n','v'}, '<Space>', 'za')

-- General Preferences
vim.opt.hlsearch=true
vim.opt.ruler=true
vim.opt.laststatus=2  -- Always enable status bar
vim.opt.number=true
vim.opt.wrap=false  -- Don't wrap long lines


-- Enable, and configure hidden chars
vim.opt.list=true
vim.opt.listchars={
  tab="→ ",
  extends="›",
  precedes="‹",
  nbsp="␣",
  trail="•",
}

vim.opt.colorcolumn = { 80 }
vim.opt.relativenumber = true

-- Colorscheme, statusline, appearance
require('bgshacklett.ui')


vim.opt.inccommand="nosplit"

vim.opt.foldmethod="expr"
vim.opt.foldlevel=0
vim.opt.foldenable=false  -- Disable folding at startup.


-- Mason installs external tools; required before its consumers below
require('bgshacklett.mason')

-- LSP, lazydev, Java, Rust
require('bgshacklett.lspconfig')

-- Debugging (nvim-dap and friends)
require('bgshacklett.debug')


-- disable command-line menu via`q:`
vim.keymap.set('n', 'q:', '<nop>')

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank() end,
})
