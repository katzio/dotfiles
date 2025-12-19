-- Disable Flash's 's' mapping so we can use sh/sj/sk/sl for window navigation
return {
  "folke/flash.nvim",
  opts = {
    modes = {
      char = {
        enabled = true,  -- Keep f/F/t/T enhancements
      },
    },
  },
  keys = function()
    -- Return only the keys we want, completely replacing LazyVim's defaults
    -- Note: 's' is NOT included here (frees up sh/sj/sk/sl for window nav)
    return {
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    }
  end,
}
