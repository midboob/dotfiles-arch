return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.nvim",
  },
  ft = { "markdown" },
  opts = {
    checkbox = {
      enabled = true,
      custom = {
        todo = {
          raw = "[~]",
          rendered = "󰥔 ",
          highlight = "RenderMarkdownTodo",
          scope_highlight = nil,
        },
        important = {
          raw = "[s]",
          rendered = "󰓎 ",
          highlight = "DiagnosticWarn",
        },
      },
    },
    latex = { enabled = false },
    html = {
      enabled = true,
      comment = {
        conceal = false,
      },
    },
    render_modes = true,
    anti_conceal = {
      enabled = true,
      ignore = {
        code_background = true,
        sign = true,
      },
      above = 0,
      below = 0,
    },
    completions = {
      lsp = { enabled = true },
      blink = { enabled = true },
    },
  },
}
