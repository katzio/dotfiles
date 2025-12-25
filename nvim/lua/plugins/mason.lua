return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "ruby-lsp",
        "basedpyright",
        "ruff",
        "clojure-lsp",
        "vtsls", -- Better TypeScript LSP

        -- Formatters & Linters
        "stylua",
        "shfmt",
        "prettier",
      },
    },
  },
}
