-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- neopywal
local neopywal = require("neopywal")
neopywal.setup()
vim.cmd.colorscheme("neopywal")
