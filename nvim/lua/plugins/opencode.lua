return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      ask = {
        blink_cmp_sources = { "opencode", "buffer" },
      },
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })
    vim.keymap.set({ "n", "x" }, "<leader>op", function()
      require("opencode").prompt("@this")
    end, { desc = "Add to opencode" })
    vim.keymap.set("n", "<leader>oe", function()
      require("opencode").prompt("explain")
    end, { desc = "Explain this" })
    vim.keymap.set("n", "<leader>of", function()
      require("opencode").prompt("fix")
    end, { desc = "Fix diagnostics" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })
    -- Keymaps using <leader>o prefix for opencode commands.
  end,
}
