-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Ensure rbenv Ruby is available in nvim's PATH for LSP/Mason
local home = os.getenv("HOME")
vim.env.PATH = home .. "/.rbenv/shims:" .. vim.env.PATH

-- Configure font for GUI clients (Neovide, etc.)
if vim.g.neovide then
  vim.g.neovide_font_face = "psudoFont Liga Mono"
end

-- For other GUI clients, set guifont
vim.opt.guifont = "psudoFont Liga Mono"

-- disable relativenumber
vim.opt.relativenumber = false

-- Enable mouse support in all modes (important for tmux scrolling)
vim.opt.mouse = "a"

-- Enable true color support (required for undercurl and other effects)
vim.opt.termguicolors = true

-- Force undercurl support for Ghostty (even with xterm-256color TERM)
vim.cmd([[
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
]])

-- Better scrolling behavior
vim.opt.scrolloff = 8 -- keep 8 lines visible when scrolling
vim.opt.sidescrolloff = 8

-- Show partial commands in the command line (what keys you're pressing)
vim.opt.showcmd = true
-- Don't set showcmdloc, let it default to command line area

-- Global diagnostic config: wrap long error messages
vim.diagnostic.config({
  float = {
    wrap = true, -- allow wrapping inside the popup
    max_width = 100, -- 0 = no artificial limit, use window width
    border = "rounded",
    focusable = false,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "InsertLeave",
      "WinLeave",
    },
    timeout = 3000, -- Default timeout for non-errors
  },
})
