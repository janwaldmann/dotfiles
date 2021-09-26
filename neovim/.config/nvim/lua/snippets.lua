local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require('luasnip.extras').lambda
local r = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local types = require('luasnip.util.types')
local events = require('luasnip.util.events')

ls.snippets = {
  all = {
    s({
      trig="#ifndef",
      name="header guard",
    },
    {
      t("#ifndef "),
      i(1, "INCLUDE_GUARD"),
      t({"", "#define "}),
      r(1),
      t({"", "", "#endif // "}),
      r(1),
    }),
    s({
      trig="/*!",
      name="Doxygen comment block",
    },
    {
      t({"/*!", " * \\brief "}),
      i(1, "The brief description"),
      t({"", " * \\details "}),
      i(2, "The detailed description"),
      t(""),
      t({"", " * \\param "}),
      i(3, "param1"),
      t(" "),
      i(4, "The description of param1"),
      t({"", " * \\return "}),
      i(5, "The desc of the return value(s)"),
      t({"", " */"}),
    }),
  }
}
