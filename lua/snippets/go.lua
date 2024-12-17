local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Error handling snippet "iferr"
ls.add_snippets("go", {
  s("iferr", {
    t { "if err != nil {", "\t" },
    i(1, "return nil, err"), -- Default return statement
    t { "", "}" },
  }),
})
