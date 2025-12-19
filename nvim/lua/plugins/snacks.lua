return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>e", false },
    { "<leader><leader>", false },
  },
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = [[
.___ _______    __________ ____ ___  ____________________  __      _____________ _____________________ ____ ___  ____________________
|   |\      \   \______   \    |   \/   _____/\__    ___/ /  \    /  \_   _____/ \__    ___/\______   \    |   \/   _____/\__    ___/
|   |/   |   \   |       _/    |   /\_____  \   |    |    \   \/\/   /|    __)_    |    |    |       _/    |   /\_____  \   |    |
|   /    |    \  |    |   \    |  / /        \  |    |     \        / |        \   |    |    |    |   \    |  / /        \  |    |
|___\____|__  /  |____|_  /______/ /_______  /  |____|      \__/\  / /_______  /   |____|    |____|_  /______/ /_______  /  |____|
            \/          \/                 \/                    \/          \/                     \/                 \/
]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = false },
    notifier = { enabled = true },
    picker = { enabled = false },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
