return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code" },
    { "<leader>as", ":<C-u>.ClaudeCodeSend<cr>", mode = "n", desc = "Send current line to Claude" },
    { "<leader>as", ":ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
  },
  opts = {
    port_range = { min = 10000, max = 65535 },
    auto_start = true,
    log_level = "info",
    focus_after_send = false,
    track_selection = true,

    terminal = {
      split_side = "right",
      split_width_percentage = 0.30,
      provider = "auto",
      auto_close = true,
    }
  }
}
