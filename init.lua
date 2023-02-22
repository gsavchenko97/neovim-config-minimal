-- [[ OPTIONS ]] 
-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Indentations
local tab_width = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = tab_width
vim.opt.tabstop = tab_width
vim.opt.softtabstop = tab_width

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Line appearance
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.cursorline = true
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Buffer
vim.opt.hidden = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- Left columns
vim.opt.number = true

-- Russian lang configurations
vim.opt.langmap =
"БЮЖФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;\\<>:ABCDEFGHIJKLMNOPQRSTUVWXYZ,бюжфисвуапршолдьтщзйкыегмцчня;\\,.;abcdefghijklmnopqrstuvwxyz"

-- Misc
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.laststatus = 3
vim.opt.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ KEYMAPS ]]

function basic_keymaps()
  local basic_keymaps_tbl = {
    n = {
      -- Window navigation
      { "<C-j>", "<C-w>j", "Go to bottom window" },
      { "<C-k>", "<C-w>k", "Go to top window" },
      { "<C-h>", "<C-w>h", "Go to left window" },
      { "<C-l>", "<C-w>l", "Go to right window" },
      -- Resize windows
      { "<C-Up>", "<cmd>resize +2<cr>", "Resize window up" },
      { "<C-Down>", "<cmd>resize -2<cr>", "Resize window down" },
      { "<C-Right>", "<cmd>vertical resize +2<cr>", "Resize window right" },
      { "<C-Left>", "<cmd>vertical resize -2<cr>", "Resize window left" },
      -- Buffers
      { "<leader>s", "<cmd>wa<cr>", "[S]ave all buffers" },
      { "<leader>ы", "<cmd>wa<cr>", "[S]ave all buffers (ru)" },
      { "<leader>q", "<cmd>qa<cr>", "[Q]uit all buffers" },
      { "<leader>й", "<cmd>qa<cr>", "[Q]uit all buffers (ru)" },
      { "<leader>w", "<cmd>bd<cr>", "Close current buffer" },
      { "<leader>ц", "<cmd>bd<cr>", "Close current buffer (ru)" },
      { "<S-h>", "<cmd>bprevious<cr>", "Previous buffer" },
      { "<S-l>", "<cmd>bnext<cr>", "Next buffer" },
    },
    v = {
      -- Move lines
      { "<", "<gv", "Move line left" },
      { ">", ">gv", "Move line right" },
      -- Paste don't reset buffer
      { "p", '"_dP', "Better paste" },
    },
  }

  for mode, mappings in pairs(basic_keymaps_tbl) do
    for _, mapping in ipairs(mappings) do
      local keymap, cmd, desc = unpack(mapping)
      vim.keymap.set(mode, keymap, cmd, { noremap = true, silent = true, desc = desc })
    end
  end

  -- Remap for dealing with word wrap
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

  -- Unmap space for leader
  vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, noremap = true })
end

basic_keymaps()
