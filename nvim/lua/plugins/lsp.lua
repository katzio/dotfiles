return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              experimental = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.ts_ls = vim.tbl_deep_extend("force", opts.servers.ts_ls or {}, {
        enabled = false,
      })

      -- Enable ruby-lsp (gem installed via rbenv)
      opts.servers.ruby_lsp = {
        mason = false, -- Don't use mason, use gem version
        enabled = true,
        cmd = { os.getenv("HOME") .. "/.rbenv/shims/ruby-lsp" },
      }

      -- Enable basedpyright for Python (modern, faster alternative to pyright)
      opts.servers.basedpyright = {
        mason = true,
        enabled = true,
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      }

      -- Enable ruff for Python linting/formatting
      opts.servers.ruff = {
        mason = true,
        enabled = true,
      }

      -- Enable clojure-lsp
      opts.servers.clojure_lsp = {
        mason = true,
        enabled = true,
      }

      -- Remove <C-k> from LSP keys (we use it for cursor movement in insert mode)
      if opts.servers and opts.servers["*"] and opts.servers["*"].keys then
        local keys = opts.servers["*"].keys
        for i = #keys, 1, -1 do
          if keys[i][1] == "<c-k>" then
            table.remove(keys, i)
          end
        end
      end

      return opts
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- Disable the documentation popup window
      opts.window = opts.window or {}
      opts.window.documentation = false

      return opts
    end,
  },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- Override <C-k> to not show signature help (use for cursor movement instead)
      opts.keymap = opts.keymap or {}
      opts.keymap["<C-k>"] = {}

      -- Disable automatic documentation popup
      opts.completion = opts.completion or {}
      opts.completion.documentation = opts.completion.documentation or {}
      opts.completion.documentation.auto_show = false
      opts.completion.documentation.auto_show_delay_ms = 500

      return opts
    end,
  },
}
