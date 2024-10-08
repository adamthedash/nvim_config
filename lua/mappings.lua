require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Quick fix
map("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = false, desc = "Quick Fix" })

-- Telescope re-bindings
unmap("n", "<leader>gt") -- git status
unmap("n", "<leader>ma") -- find marks
unmap("n", "<leader>cm") -- git commits
unmap("n", "<leader>th") -- themes
unmap("n", "<leader>pt") -- hidden terminals

map("n", "<leader>ft", "<CMD>Telescope terms<CR>", { desc = "telescope hidden terminals" })

map("n", "<leader>fgs", "<CMD>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>fgc", "<CMD>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>fgb", "<CMD>Telescope git_branches<CR>", { desc = "telescope git branches" })
map("n", "<leader>fgf", "<CMD>Telescope git_files<CR>", { desc = "telescope git-tracked files" })

map("n", "<leader>cs", "<CMD>Telescope spell_suggest<CR>", { desc = "telescope spell suggest" })
