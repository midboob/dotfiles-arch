-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- neopywal
local neopywal = require("neopywal")
neopywal.setup()
vim.cmd.colorscheme("neopywal")

-- open typst in zathura
vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)

  if filepath:match("%.typ$") then
    local pdf_path = filepath:gsub("%.typ$", ".pdf")

    vim.system({ "open", pdf_path })
  end
end, {})
