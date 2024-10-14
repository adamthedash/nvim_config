-- Keymaps
local cur_buffer = vim.api.nvim_get_current_buf()
local map = vim.keymap.set

map("n", "<leader>ct", function()
  vim.cmd.RustLsp "testables"
end, { silent = true, buffer = cur_buffer, desc = "Run tests" })

map("n", "<leader>cT", function()
  vim.cmd.RustLsp { "testables", bang = true }
end, { silent = true, buffer = cur_buffer, desc = "Run last test" })

map("n", "<leader>ca", function()
  vim.cmd.RustLsp { "codeAction" }
end, { silent = true, buffer = cur_buffer, desc = "Code Action" })

-- vim.g.rustaceanvim.tools.code_actions.ui_select_fallback = true -- this screws up my theme syntax highlighting for some reason
