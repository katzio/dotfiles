return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle reveal<cr>", desc = "Toggle Neo-tree" },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
    },
  },
  config = function(_, opts)
    -- Set up neo-tree with options
    require("neo-tree").setup(opts)

    -- Set folder icons and names to yellow-orange
    vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#e0af68" }) -- Tokyo Night yellow
    vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#e0af68" })
    vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#e0af68", bold = true })

    -- Set file names to white (unless overridden by state)
    vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#c0caf5" }) -- Tokyo Night white/foreground
  end,
}
