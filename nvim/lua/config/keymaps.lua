-- Keymaps are automatically loaded on VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

----------------------------------------------------------------------
-- Window navigation (s prefix) and splits
----------------------------------------------------------------------
-- Disable default 's' (substitute) to use as prefix
keymap.set("n", "s", "<Nop>", opts)

-- Window navigation
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sk", "<C-w>k", opts)
keymap.set("n", "sl", "<C-w>l", opts)

-- Splits
keymap.set("n", "ss", "<cmd>vsplit<CR>", opts)
keymap.set("n", "sv", "<cmd>split<CR>", opts)

----------------------------------------------------------------------
-- Keymap Namespace Documentation
----------------------------------------------------------------------
-- Reserved leader key prefixes to avoid conflicts:
-- <leader>b - Buffer operations
-- <leader>c - Code operations
-- <leader>f - File operations
-- <leader>g - Git operations
-- <leader>s - Search operations
-- <leader>t - Test operations
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Disable LazyVim default recent files picker (we use fzf instead)
----------------------------------------------------------------------
pcall(vim.keymap.del, "n", "<leader>fR")

----------------------------------------------------------------------
-- Select all on Ctrl+A
----------------------------------------------------------------------
keymap.set("n", "<C-a>", "gg<S-v>G", opts)

----------------------------------------------------------------------
-- Increment / Decrement numbers
-- + calls the original <C-a> so numeric inc still works
----------------------------------------------------------------------
keymap.set("n", "+", "<C-a>", { noremap = false, silent = true })
keymap.set("n", "-", "<C-x>", opts)

----------------------------------------------------------------------
-- Cursor position history (track every movement)
----------------------------------------------------------------------
local cursor_history = {}
local cursor_history_index = 0
local max_history = 100

-- Save cursor position before movement
local function save_cursor_pos()
  local pos = vim.api.nvim_win_get_cursor(0)
  local buf = vim.api.nvim_get_current_buf()

  -- Don't save if position hasn't changed
  if cursor_history_index > 0 then
    local last = cursor_history[cursor_history_index]
    if last and last.buf == buf and last.pos[1] == pos[1] and last.pos[2] == pos[2] then
      return
    end
  end

  -- Remove any forward history when adding new position
  while #cursor_history > cursor_history_index do
    table.remove(cursor_history)
  end

  -- Add new position
  table.insert(cursor_history, { buf = buf, pos = pos })
  cursor_history_index = #cursor_history

  -- Keep history size limited
  if #cursor_history > max_history then
    table.remove(cursor_history, 1)
    cursor_history_index = cursor_history_index - 1
  end
end

-- Go back in cursor history
local function cursor_back()
  if cursor_history_index > 1 then
    cursor_history_index = cursor_history_index - 1
    local entry = cursor_history[cursor_history_index]

    -- Check if buffer is valid
    if vim.api.nvim_buf_is_valid(entry.buf) then
      pcall(vim.api.nvim_set_current_buf, entry.buf)
      pcall(vim.api.nvim_win_set_cursor, 0, entry.pos)
    else
      -- Buffer invalid, try going back further
      cursor_back()
    end
  end
end

-- Go forward in cursor history
local function cursor_forward()
  if cursor_history_index < #cursor_history then
    cursor_history_index = cursor_history_index + 1
    local entry = cursor_history[cursor_history_index]

    -- Check if buffer is valid
    if vim.api.nvim_buf_is_valid(entry.buf) then
      pcall(vim.api.nvim_set_current_buf, entry.buf)
      pcall(vim.api.nvim_win_set_cursor, 0, entry.pos)
    else
      -- Buffer invalid, try going forward further
      cursor_forward()
    end
  end
end

-- Track cursor movements
vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    save_cursor_pos()
  end,
})

-- Ctrl+O to go back, Ctrl+I to go forward (similar to vim's jumplist)
-- Or use Alt+Left/Right for browser-like navigation
keymap.set("n", "<M-Left>", cursor_back, opts)
keymap.set("n", "<M-Right>", cursor_forward, opts)
keymap.set("n", "<C-o>", cursor_back, opts)
keymap.set("n", "<C-i>", cursor_forward, opts)

----------------------------------------------------------------------
-- Buffers (this is what the top bar shows)
----------------------------------------------------------------------
-- New empty buffer
keymap.set("n", "te", "<cmd>enew<CR>", opts)

-- Navigate buffers
keymap.set("n", "<Tab>", "<cmd>bnext<CR>", opts)
keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", opts)

-- Close buffer (moved to <leader>b to free up <leader>c for code operations)
keymap.set("n", "<leader>b", function()
  Snacks.bufdelete()
end, { noremap = true, silent = true, desc = "Delete Buffer" })
keymap.set("n", "<leader>B", function()
  Snacks.bufdelete({ force = true })
end, { noremap = true, silent = true, desc = "Delete Buffer (Force)" })

----------------------------------------------------------------------
-- Diagnostics navigation (new API)
----------------------------------------------------------------------
vim.keymap.set("n", "<C-e>", function()
  vim.diagnostic.open_float(nil, { focus = true })
end)

----------------------------------------------------------------------
-- Telescope diagnostics
----------------------------------------------------------------------
vim.keymap.set(
  "n",
  "<leader>Td",
  "<cmd>Telescope diagnostics<CR>",
  { noremap = true, silent = true, desc = "Telescope Diagnostics" }
)

-- Exit terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

-- Arrow keys enabled for navigation

-- Disable Shift + arrows
vim.keymap.set({ "n", "i", "v" }, "<S-Left>", "")
vim.keymap.set({ "n", "i", "v" }, "<S-Right>", "")
vim.keymap.set({ "n", "i", "v" }, "<S-Up>", "")
vim.keymap.set({ "n", "i", "v" }, "<S-Down>", "")

-- Disable Ctrl + arrows
vim.keymap.set({ "n", "i", "v" }, "<C-Left>", "")
vim.keymap.set({ "n", "i", "v" }, "<C-Right>", "")
vim.keymap.set({ "n", "i", "v" }, "<C-Up>", "")
vim.keymap.set({ "n", "i", "v" }, "<C-Down>", "")

-- Disable PageUp / PageDown
vim.keymap.set({ "n", "i", "v" }, "<PageUp>", "")
vim.keymap.set({ "n", "i", "v" }, "<PageDown>", "")

-- Disable Home / End
vim.keymap.set({ "n", "i", "v" }, "<Home>", "")
vim.keymap.set({ "n", "i", "v" }, "<End>", "")

-- Disable mouse
-- vim.opt.mouse = ""  -- Commented out to enable mouse scrolling in tmux

vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true })

-- Show last message history
vim.keymap.set("n", "<leader>nh", function()
  require("noice").cmd("history")
end, { desc = "Noice History" })
-- Dismiss all notifications
vim.keymap.set("n", "<leader>nd", function()
  require("noice").cmd("dismiss")
end, { desc = "Dismiss Noice Messages" })
