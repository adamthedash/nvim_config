-- IntelliJ Darcula Theme for NVChad Base46
local M = {}

M.base_30 = {
  white = "#a9b7c6",
  darker_black = "#2b2b2b",
  black = "#313335", -- nvim bg
  black2 = "#323232",
  one_bg = "#3e3e3e", -- real bg of onedark
  one_bg2 = "#4c4c4c",
  one_bg3 = "#5a5a5a",
  grey = "#6e6e6e",
  grey_fg = "#7e7e7e",
  grey_fg2 = "#8e8e8e",
  light_grey = "#9e9e9e",
  red = "#cc7832",
  baby_pink = "#ff6b68",
  pink = "#c57825",
  line = "#424242", -- for lines like vertsplit
  green = "#5e8759",
  vibrant_green = "#7ca8c6",
  nord_blue = "#214283",
  blue = "#214283",
  yellow = "#b1c73d",
  sun = "#ffc66d",
  purple = "#9676ac",
  dark_purple = "#8a72a5",
  teal = "#5e8759",
  orange = "#ff9e3b",
  cyan = "#7ca8c6",
  statusline_bg = "#323232",
  lightbg = "#393939",
  pmenu_bg = "#c57825",
  folder_bg = "#9676ac",
}

M.base_16 = {
  base00 = "#2b2b2b", -- background
  base01 = "#323232", -- lighter background (statusline)
  base02 = "#393939", -- selection background
  base03 = "#888888", -- comments, invisibles, line highlighting
  base04 = "#a9b7c6", -- dark foreground (statusline text, popups)
  base05 = "#ffffff", -- default foreground
  base06 = "#7ca8c6", -- lighter foreground (statusline)
  base07 = "#b1c73d", -- lightest foreground
  base08 = "#cc7832", -- variables, XML tags, markup link text, lists, diff deleted
  base09 = "#ffc66d", -- integers, boolean, constants, XML attributes, markup link url
  base0A = "#c57825", -- classes, markup bold, search text background
  base0B = "#5e8759", -- strings, inherited class, markup code, diff inserted
  base0C = "#7ca8c6", -- support, regular expressions, escape characters, markup quotes
  base0D = "#214283", -- functions, methods, attribute IDs, headings
  base0E = "#9676ac", -- keywords, storage, selector, markup italic, diff changed
  base0F = "#8e9292", -- deprecated, open/close embedded tags, error highlighting
}

M.type = "dark" -- Set the type to dark

M.polish_hl = {
  Comment = { fg = M.base_16.base03 },
  Keyword = { fg = M.base_16.base0A, bold = true },
  Function = { fg = M.base_16.base0D, bold = true },
  String = { fg = M.base_16.base0B },
  Constant = { fg = M.base_16.base09, bold = true },
  Type = { fg = M.base_16.base0A, bold = true },
  Operator = { fg = M.base_16.base04 },
  Identifier = { fg = M.base_16.base08 },
  LineNr = { fg = M.base_30.grey_fg },
  VertSplit = { fg = M.base_30.line, bg = M.base_30.black2 },
  CursorLineNr = { fg = M.base_30.yellow },
  Visual = { bg = M.base_30.nord_blue },
}

return M
