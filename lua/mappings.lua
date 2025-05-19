require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Quick fix
map("n", "<leader>cq", vim.lsp.buf.code_action, { noremap = true, silent = false, desc = "Quick Fix" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

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

-- Other re-bindings
unmap("n", "<leader>ch") -- NvCheatsheet

-- Abbreviations
vim.cmd "ab h vert help" -- https://stackoverflow.com/a/630913

-- LLM Stuff
local llm_enabled, llm_completion = pcall(require, "llm.completion")
if llm_enabled then
  map("i", "<C-E>", llm_completion.accept_suggestion, { desc = "Accept LLM suggestion" })
  map("n", "<Esc>", llm_completion.dismiss_suggestion, { desc = "Dismiss LLM suggestion" })
end

-- Windsurf / Codeium
vim.g.codeium_no_map_tab = 1
map("i", "<C-E>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })
