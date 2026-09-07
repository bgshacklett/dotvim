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

  -- Language Enhancements. vim-polyglot (below) bundles json, puppet, ps1, jq,
  -- helm, python-syntax and python-pep8-indent, so those are not listed here.
  "https://github.com/Rykka/InstantRst",             -- reST live preview
  "https://github.com/pedrohdz/vim-yaml-folds",      -- folding
  "https://github.com/hashivim/vim-vagrant",
  "https://github.com/hashivim/vim-packer",
  "https://github.com/Glench/Vim-Jinja2-Syntax",     -- also detects *.j2, which core doesn't

  -- Terminal/Environment Integrations
  "https://github.com/bgshacklett/vitality.vim",

  "https://github.com/powerman/vim-plugin-AnsiEsc",

  -- Feature Enhancements
  "https://github.com/Yggdroot/indentLine", -- No longer maintained
  "https://github.com/tmhedberg/SimpylFold",
  -- "https://github.com/Konfekt/FastFold",
  "https://github.com/wfaulk/iRuler.vim",

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
vim.g.markdown_syntax_conceal = 0  -- Don't conceal characters; it's annoying.

-- Filetype detection. Helm templates are YAML or .tpl files that use Go
-- template syntax with Helm's built-in objects, so detect them by content
-- rather than by path. Returning nil falls through to normal detection.
local function detect_helm(_, bufnr)
  local markers = {
    "%.Values%f[%W]", "%.Release%f[%W]", "%.Chart%f[%W]", "%.Capabilities%f[%W]",
    "%f[%w]include%s+\"", "%f[%w]toYaml%f[%W]", "%f[%w]tpl%s+\"",
  }
  for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, 50, false)) do
    if line:find("{{", 1, true) then
      for _, m in ipairs(markers) do
        if line:find(m) then return "helm" end
      end
    end
  end
end

vim.filetype.add({
  pattern = {
    [".*%.ya?ml"] = detect_helm,
    [".*%.tpl"] = detect_helm,
  },
})

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

-- Treesitter parsers and highlighting
require('bgshacklett.treesitter')


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
