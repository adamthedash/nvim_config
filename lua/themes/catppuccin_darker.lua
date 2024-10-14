-- Combination of cattppuccin for text and jellybeans for background colors

---@type Base46Table
local M = {}

M.base_30 = {
  white = "#e8e8d3",
  darker_black = "#101010",
  black = "#151515", --  nvim bg
  black2 = "#1c1c1c",
  one_bg = "#252525",
  one_bg2 = "#2e2e2e",
  one_bg3 = "#3a3a3a",
  grey = "#424242",
  grey_fg = "#474747",
  grey_fg2 = "#4c4c4c",
  light_grey = "#525252",
  red = "#F38BA8",
  baby_pink = "#ffa5c3",
  pink = "#F5C2E7",
  line = "#383747", -- for lines like vertsplit
  green = "#ABE9B3",
  vibrant_green = "#b6f4be",
  nord_blue = "#8bc2f0",
  blue = "#89B4FA",
  yellow = "#FAE3B0",
  sun = "#ffe9b6",
  purple = "#d0a9e5",
  dark_purple = "#c7a0dc",
  teal = "#B5E8E0",
  orange = "#F8BD96",
  cyan = "#89DCEB",
  statusline_bg = "#232232",
  lightbg = "#2f2e3e",
  pmenu_bg = "#ABE9B3",
  folder_bg = "#89B4FA",
  lavender = "#c7d1ff",
}

M.base_16 = {
  base00 = "#151515",
  base01 = "#282737",
  base02 = "#2f2e3e",
  base03 = "#383747",
  base04 = "#414050",
  base05 = "#bfc6d4",
  base06 = "#ccd3e1",
  base07 = "#D9E0EE",
  base08 = "#F38BA8",
  base09 = "#F8BD96",
  base0A = "#FAE3B0",
  base0B = "#ABE9B3",
  base0C = "#89DCEB",
  base0D = "#56a8f5",
  base0E = "#cf8e6d",
  base0F = "#F38BA8",
}

M.polish_hl = {
  treesitter = {
    ["@variable"] = { fg = M.base_30.lavender },
    ["@variable.parameter"] = { fg = M.base_30.lavender },
    ["@lsp.type.struct.rust"] = { fg = M.base_30.lavender },
    ["@lsp.type.interface.rust"] = { fg = M.base_30.lavender },
    ["@lsp.type.enum.rust"] = { fg = M.base_30.lavender },
    ["Type"] = { fg = M.base_16.base0E },
    ["@property"] = { fg = M.base_30.teal },
    ["@variable.builtin"] = { fg = M.base_30.red },
    ["@constant.macro"] = { fg = M.base_30.pink },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "catppuccin_darker")

return M
