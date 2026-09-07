-- Mason: installs external tools (language servers, DAP adapters, linters,
-- formatters) and puts them on PATH. It is a shared dependency, so it lives
-- in its own module and is required before its consumers.
--
-- Consumers: lspconfig (servers), debug (adapters).

vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
})

require("mason").setup()
