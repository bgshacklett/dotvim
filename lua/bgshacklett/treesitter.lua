-- Treesitter: parser installation and highlighting.
--
-- nvim-treesitter's main branch is only a parser installer; enabling the
-- highlighter is done here. Needs the tree-sitter CLI (installed via mason),
-- a C compiler, curl, and tar. Indentation is left to the ftplugin/indent
-- files; to opt a filetype into treesitter indentation, set
--   vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
-- in its after/ftplugin file.
--
-- This module owns its own plugins, including dependencies.

-- Languages to keep parsers for. Adding one here installs it on next start.
local parsers = {
  -- config / data
  "json", "toml", "yaml", "xml", "ini", "csv",
  -- shell / infra
  "bash", "dockerfile", "hcl", "terraform", "helm", "puppet", "jq", "make",
  -- vcs
  "diff", "gitcommit", "git_config", "git_rebase", "gitignore",
  -- languages
  "c", "go", "gomod", "gosum", "groovy", "haskell", "java", "javascript",
  "typescript", "tsx", "lua", "luadoc", "pascal", "php", "powershell",
  "python", "ruby", "rust", "sql",
  -- markup
  "html", "css", "markdown", "markdown_inline", "rst", "jinja",
  -- neovim itself
  "vim", "vimdoc", "query", "regex",
}

-- Keep parsers in step with the plugin: after nvim-treesitter updates, rebuild.
-- Registered before vim.pack.add so it also fires on first install.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- Install anything from the list that is missing. Async; notifies on completion.
local ts = require("nvim-treesitter")
local installed = ts.get_installed("parsers")
local missing = vim.tbl_filter(function(p) return not vim.list_contains(installed, p) end, parsers)
if #missing > 0 then
  ts.install(missing)
end

-- Highlight with treesitter wherever a parser is available. start() errors when
-- there is no parser for the buffer's language, so it is wrapped; those
-- buffers keep regex syntax highlighting.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("bgshacklett_treesitter", { clear = true }),
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
