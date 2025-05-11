-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- neopywal/matugen
local neopywal = require("neopywal")
neopywal.setup()
vim.cmd.colorscheme("neopywal")

-- clipboard
vim.opt.clipboard = "unnamedplus"
