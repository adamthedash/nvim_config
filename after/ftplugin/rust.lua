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

---@param rendered_diagnostic string
local function render_ansi_code_diagnostic(rendered_diagnostic)
  --- A chopped down verson of rustaceanvim's rendering function https://github.com/mrcjkb/rustaceanvim/blob/master/lua/rustaceanvim/commands/diagnostic.lua#L240
  local config = require "rustaceanvim.config.internal"

  -- adopted from https://stackoverflow.com/questions/48948630/lua-ansi-escapes-pattern
  local lines =
    vim.split(rendered_diagnostic:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", ""), "\n", { trimempty = true })
  local float_preview_lines = vim.deepcopy(lines)
  vim.schedule(function()
    local bufnr, winnr =
      vim.lsp.util.open_floating_preview(float_preview_lines, "plaintext", config.tools.float_win_config)
    vim.api.nvim_create_autocmd("WinEnter", {
      callback = function()
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes(
            [[<c-\><c-n>]] .. "<cmd>lua vim.api.nvim_win_set_cursor(" .. winnr .. ",{1,0})<CR>",
            true,
            false,
            true
          ),
          "n",
          true
        )
      end,
      buffer = bufnr,
    })

    local chanid = vim.api.nvim_open_term(bufnr, {})
    vim.api.nvim_chan_send(chanid, vim.trim(rendered_diagnostic))
  end)
end

local function cycle_diagnostics_on_current_line()
  local current_line = vim.fn.line "." - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = current_line, severity = { min = vim.diagnostic.severity.WARN } }) -- Get diagnostics on the current line
  if #diagnostics == 0 then
    vim.notify("No diagnostics on this line", vim.log.levels.INFO)
    return
  end

  -- If the current line is different from the previously checked line, reset our indexes
  local last_line = vim.b["diagnostics_last_line_checked"]
  if current_line ~= last_line then
    vim.b["diagnostics_index"] = 1
    vim.b["diagnostics_last_line_checked"] = current_line
  end

  -- If our current index is longer than the number of diagnostics (eg. if we fixed something but haven't changed lines), reset back to the start
  local current_index = vim.b["diagnostics_index"]
  if current_index > #diagnostics then
    current_index = 1
    vim.b["diagnostics_index"] = current_index
  end

  -- Grab the current diagnostic item
  local diagnostic = diagnostics[current_index]

  -- If there's some rich info from the diagnostic (i.e. a nice compiler message showing you where exactly the error is) convert it to a nice format with colours
  local rich_diag_message = vim.tbl_get(diagnostic, "user_data", "lsp", "data", "rendered")
  render_ansi_code_diagnostic(rich_diag_message or diagnostic.message)

  -- Move the cursor to where the issue is
  vim.cmd "normal! m'" -- for jump list
  local win_id = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_cursor(win_id, { diagnostic.lnum + 1, diagnostic.col })

  -- Move to the next diagnostic in the list (loop around)
  vim.b["diagnostics_index"] = (current_index % #diagnostics) + 1
end

-- Map the function to <leader>cb
map("n", "<leader>cb", function()
  cycle_diagnostics_on_current_line()
end, { noremap = true, silent = true })
