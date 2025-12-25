return {
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "janet", "racket", "scheme" },
    lazy = true,
    init = function()
      -- Disable default mappings if you want to customize them
      -- vim.g["conjure#mapping#doc_word"] = false
    end,
    config = function()
      -- Configure Conjure settings
      vim.g["conjure#log#hud#width"] = 1
      vim.g["conjure#log#hud#enabled"] = true
      vim.g["conjure#log#hud#anchor"] = "SE"
      vim.g["conjure#log#wrap"] = true

      -- Clojure specific settings
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
      vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = true
    end,
  },
}
