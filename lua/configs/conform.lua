local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = {
      -- To fix auto-fixable lint errors.
      "ruff_fix",
      -- To run the Ruff formatter.
      "ruff_format",
      -- To organize the imports.
      "ruff_organize_imports",
    },
    rust = { "rustfmt", "leptosfmt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    rustfmt = {
      command = "rustfmt",
      stdin = true,
    },
    leptosfmt = {
      command = "leptosfmt",
      args = { "--stdin" },
      stdin = true,
    },
  },
}
return options
