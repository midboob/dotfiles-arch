local filetype = { 'markdown', 'text', 'tex', 'plaintex', 'norg' }

return {
  'gaoDean/autolist.nvim',
  enabled = true,
  ft = filetype,
  opts = {},
  keys = {
    { '<CR>', '<CR><cmd>AutolistNewBullet<cr>', mode = { 'i' }, ft = filetype },
    { 'o', 'o<cmd>AutolistNewBullet<cr>', mode = { 'n' }, ft = filetype },
    { 'O', 'O<cmd>AutolistNewBulletBefore<cr>', mode = { 'n' }, ft = filetype },
    { '<CR>', '<cmd>AutolistToggleCheckbox<cr><CR>', mode = { 'n' }, ft = filetype },
    { '<C-r>', '<cmd>AutolistRecalculate<cr>', mode = { 'n' }, ft = filetype },

    { '].', '<cmd>AutolistCycleNext<cr>', mode = { 'n' }, desc = 'Next List Type', ft = filetype },
    { '[.', '<cmd>AutolistCyclePrev<cr>', mode = { 'n' }, desc = 'Prev List Type', ft = filetype },

    { '>>', '>><cmd>AutolistRecalculate<cr>', mode = { 'n' }, ft = filetype },
    { '<<', '<<<cmd>AutolistRecalculate<cr>', mode = { 'n' }, ft = filetype },
    { 'dd', 'dd<cmd>AutolistRecalculate<cr>', mode = { 'n' }, ft = filetype },
    { 'd', 'd<cmd>AutolistRecalculate<cr>', mode = { 'v' }, ft = filetype },
  },
}
