-- Debugging: Debug Adapter Protocol client and UI.
--
-- This module owns its own plugins, including dependencies. Listing a
-- dependency here that another module also lists is fine; vim.pack skips
-- plugins that are already active and errors on conflicting versions.

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",            -- Lua utility functions
  "https://github.com/nvim-neotest/nvim-nio",            -- Async IO, required by nvim-dap-ui
  "https://github.com/mfussenegger/nvim-dap",            -- DAP client
  "https://github.com/rcarriga/nvim-dap-ui",             -- UI for nvim-dap
  "https://github.com/theHamsta/nvim-dap-virtual-text",  -- 
  "https://github.com/leoluz/nvim-dap-go",               -- Go adapter configuration
  "https://github.com/folke/lazydev.nvim",               -- Recommended by nvim-dap-ui for
                                                         -- Lua type hints; not yet configured
})

local dap = require("dap")
local ui = require("dapui")
require("nvim-dap-virtual-text").setup()

require("dap-go").setup()
ui.setup()


local function map(lhs, rhs, desc, mode)
  vim.keymap.set(mode or "n", lhs, rhs, { desc = "DAP: " .. desc })
end

local function evalUnderCursor()
  ui.eval(nil, { enter = true })
end

-- Breakpoints
map("<leader>db", dap.toggle_breakpoint, "toggle breakpoint")
map("<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "conditional breakpoint")

-- Session
map("<leader>dc", dap.continue, "continue / start")
map("<leader>dC", dap.run_to_cursor, "run to cursor")
map("<leader>dl", dap.run_last, "run last")
map("<leader>dt", dap.terminate, "terminate")
map("<leader>dp", dap.pause, "pause")

-- Stepping (mnemonic)
map("<leader>di", dap.step_into, "step into")
map("<leader>do", dap.step_over, "step over")
map("<leader>dO", dap.step_out, "step out")
map("<leader>dj", dap.down, "frame down")
map("<leader>dk", dap.up, "frame up")

-- Stepping (hot loop)
map("<F5>", dap.continue, "continue")
map("<F10>", dap.step_over, "step over")
map("<F11>", dap.step_into, "step into")
map("<F12>", dap.step_out, "step out")

-- Inspect
map("<leader>dr", dap.repl.toggle, "toggle REPL")
map("<leader>du", ui.toggle, "toggle UI")
map("<leader>de", evalUnderCursor, "eval", { "n", "v" })

-- Open and close the UI with the debug session.
dap.listeners.before.attach.dapui_config = function() ui.open() end
dap.listeners.before.launch.dapui_config = function() ui.open() end
dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
dap.listeners.before.event_exited.dapui_config = function() ui.close() end
