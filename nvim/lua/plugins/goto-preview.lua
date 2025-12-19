return {
  "rmagatti/goto-preview",
  event = "LspAttach",
  config = function()
    require("goto-preview").setup({
      width = 120,
      height = 15,
      default_mappings = false,
      debug = false,
      opacity = nil,
    })

    -- Keymaps
    vim.keymap.set("n", "gpd", function()
      require("goto-preview").goto_preview_definition()
    end, { desc = "Preview Definition" })

    vim.keymap.set("n", "gpt", function()
      require("goto-preview").goto_preview_type_definition()
    end, { desc = "Preview Type Def" })

    vim.keymap.set("n", "gpi", function()
      require("goto-preview").goto_preview_implementation()
    end, { desc = "Preview Implementation" })

    vim.keymap.set("n", "gpr", function()
      require("goto-preview").goto_preview_references()
    end, { desc = "Preview References" })

    vim.keymap.set("n", "gpq", function()
      require("goto-preview").close_all_win()
    end, { desc = "Close All Preview Windows" })
  end,
}
