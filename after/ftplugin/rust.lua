-- Keymaps
local cur_buffer = vim.api.nvim_get_current_buf()
local map = vim.keymap.set

map("n", "<leader>ct", function()
  vim.cmd.RustLsp "testables"
end, { silent = true, buffer = cur_buffer, desc = "Run tests" })

map("n", "<leader>cT", function()
  vim.cmd.RustLsp { "testables", bang = true }
end, { silent = true, buffer = cur_buffer, desc = "Run last test" })
