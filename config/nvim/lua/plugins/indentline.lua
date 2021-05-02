-- Specifies a list of |buftype| values for which this plugin is not enabled.
vim.g.indent_blankline_buftype_exclude = {'terminal'}

-- Specifies a list of |filetype| values for which this plugin is not enabled.
vim.g.indent_blankline_filetype_exclude = {'help', 'startify', 'packer'}

-- Specifies the character to be used as indent line.
vim.g.indent_blankline_char = '▏'

-- Do not show indentation for the first line
vim.g.indent_blankline_show_first_indent_level = false

-- Use treesitter to calculate indentation when possible.
-- As far as I know this settign do not show indent char for the blank lines
-- between lines of code
-- vim.g.indent_blankline_use_treesitter = true

-- Displays a trailing indentation guide on blank lines, to match the
-- indentation of surrounding code.
-- Turn this off if you want to use background highlighting instead of chars.
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Highlight of indent character when base of current context.
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
  'class', 'return', 'function', 'method', '^if', '^while', 'jsx_element', '^for', '^object',
  '^table', 'block', 'arguments', 'if_statement', 'else_clause', 'jsx_element', 'jsx_self_closing_element',
  'try_statement', 'catch_clause', 'import_statement'
}
