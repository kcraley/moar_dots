-- 1337.nvim is a Lua port of Visual Studio Code's 1337 theme.
-- https://github.com/microsoft/vscode-themes/tree/main/1337

local defaults = {
  transparent = true,
}

local M = {}

-- Define colors which make up the theme.
M.colors = {
  bg = "#191919",
  fg = "#F8F8F2",
  caret = "#F8F8F0",
  invis = "#3B3A32",
  linehl = "#3D3D3D",
  select = "#515151",

  comment = "#6d6d6d",
  strings = "#fbe3bf",
  number = "#fdb082",
  builtin = "#ff8942",
  variable = "#e9fdac",
  keyword = "#ff5e5e",
  type = "#fbdfb5",
  func = "#8cdaff",
  param = "#fc9354",
  tag = "#ff5e5e",
  attr = "#97d8ea",
  libfunc = "#6699cc",
  libconst = "#ecfdb9",
  namespace = "#FFB2F9",

  invalid = "#f92649",
  deprecated = "#ff9664",
  punct = "#ffffff",
  text = "#d0d0d0",
  id = "#66a9ec",
}

-- Set highlights for different groups building the colorscheme.
local function set_hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Perform the plugin setup.
function M.setup()
  local c = M.colors

  --opts = vim.tbl_deep_extend("force", defaults, opts or {})

  vim.cmd("highlight clear")
  vim.o.termguicolors = true
  vim.g.colors_name = "1337"

  --local bg = opts.transparent and "NONE" or c.bg

  -- UI.
  set_hl("Normal", { fg = c.fg, bg = c.bg })
  set_hl("Cursor", { fg = c.bg, bg = c.caret })
  set_hl("LineNr", { fg = c.comment, bg = c.bg })
  set_hl("CursorLine", { bg = c.linehl })
  set_hl("Visual", { bg = c.select })
  set_hl("NonText", { fg = c.invis })
  set_hl("Whitespace", { fg = c.invis })

  -- Floating UI.
  set_hl("NormalFloat", { fg = c.fg, bg = c.bg })
  set_hl("FloatBorder", { fg = c.comment, bg = c.bg })
  set_hl("SignColumn", { bg = c.bg })

  -- Core syntax.
  set_hl("Comment", { fg = c.comment })
  set_hl("Cursor", { fg = c.strings })
  set_hl("Number", { fg = c.number })
  set_hl("Boolean", { fg = c.builtin })
  set_hl("Constant", { fg = c.number })
  set_hl("Identifier", { fg = c.variable })
  set_hl("Keyword", { fg = c.keyword })
  set_hl("Statement", { fg = c.keyword })
  set_hl("Type", { fg = c.type, italic = true })
  set_hl("Function", { fg = c.func })
  set_hl("Parameter", { fg = c.param, italic = true })
  set_hl("Operator", { fg = c.keyword })
  set_hl("Punctuation", { fg = c.punct })

  -- HTML / XML.
  set_hl("Tag", { fg = c.tag })
  set_hl("Attribute", { fg = c.attr })
  set_hl("htmlArg", { fg = c.attr })
  set_hl("htmlTagName", { fg = c.tag })

  -- Library / support.
  set_hl("Special", { fg = c.libfunc })
  set_hl("PreProc", { fg = c.libconst })

  -- Namespaces.
  set_hl("Namespace", { fg = c.namespace })

  -- Errors.
  set_hl("Error", { fg = c.invalid })
  set_hl("WarningMsg", { fg = c.deprecated })

  -- Treesitting mappings
  set_hl("@comment", { fg = c.comment })
  set_hl("@string", { fg = c.strings })
  set_hl("@number", { fg = c.number })
  set_hl("@boolean", { fg = c.builtin })
  set_hl("@constant", { fg = c.number })
  set_hl("@variable", { fg = c.variable })
  set_hl("@keyword", { fg = c.keyword })
  set_hl("@type", { fg = c.type, italic = true })
  set_hl("@function", { fg = c.func })
  set_hl("@parameter", { fg = c.param, italic = true })
  set_hl("@tag", { fg = c.tag })
  set_hl("@attribute", { fg = c.attr })
  set_hl("@punctuation", { fg = c.punct })
  set_hl("@text", { fg = c.text })
end

return M
