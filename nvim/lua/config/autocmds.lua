-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

----------------------------------------------------------------------
-- Track session-only recent files
----------------------------------------------------------------------
_G.session_recent_files = _G.session_recent_files or {}

local function add_to_session_recent(filepath)
  if filepath and filepath ~= "" and vim.fn.filereadable(filepath) == 1 then
    -- Remove if already exists (to move it to front)
    for i, f in ipairs(_G.session_recent_files) do
      if f == filepath then
        table.remove(_G.session_recent_files, i)
        break
      end
    end
    -- Add to front of list
    table.insert(_G.session_recent_files, 1, filepath)
    -- Keep only last 50 files
    if #_G.session_recent_files > 50 then
      table.remove(_G.session_recent_files)
    end
  end
end

-- Track when files are opened
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function(ev)
    local filepath = vim.api.nvim_buf_get_name(ev.buf)
    add_to_session_recent(filepath)
  end,
  desc = "Track session recent files",
})

-- Global dismiss key for all notifications and diagnostics
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "notify", "diagnostic" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", {
      desc = "Dismiss notification/diagnostic",
      silent = true,
      buffer = true,
    })
  end,
  desc = "Set q to dismiss notifications and diagnostics",
})