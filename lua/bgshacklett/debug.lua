-- Debugging: Debug Adapter Protocol client and UI.
--
-- This module owns its own plugins, including dependencies. Listing a
-- dependency here that another module also lists is fine; vim.pack skips
-- plugins that are already active and errors on conflicting versions.

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",     -- Lua utility functions
  "https://github.com/nvim-neotest/nvim-nio",     -- Async IO, required by nvim-dap-ui
  "https://github.com/mfussenegger/nvim-dap",     -- DAP client
  "https://github.com/rcarriga/nvim-dap-ui",      -- UI for nvim-dap
  "https://github.com/leoluz/nvim-dap-go",        -- Go adapter configuration
  "https://github.com/folke/lazydev.nvim",        -- Recommended by nvim-dap-ui for
                                                  -- Lua type hints; not yet configured
})

local dap = require("dap")
local dapui = require("dapui")

require("dap-go").setup()
dapui.setup()

-- Open and close the UI with the debug session.
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
