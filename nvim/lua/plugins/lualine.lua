return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.options = opts.options or {}
    opts.options.theme = "tokyonight"

    opts.sections = opts.sections or {}

    -- Left side - Mode
    opts.sections.lualine_a = { "mode" }

    -- Git branch and diff
    opts.sections.lualine_b = {
      "branch",
      "diff",
    }

    -- Filename with full relative path
    opts.sections.lualine_c = {
      {
        "filename",
        path = 1, -- Show relative path
        shorting_target = 40,
        symbols = {
          modified = " ●",
          readonly = " ",
          unnamed = "[No Name]",
        },
      },
      {
        "diagnostics",
        sources = { "nvim_lsp" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
    }

    -- Right side - File info
    opts.sections.lualine_x = {
      {
        function()
          local msg = "No LSP"
          local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
          if next(buf_clients) == nil then
            return msg
          end
          local buf_client_names = {}
          for _, client in pairs(buf_clients) do
            table.insert(buf_client_names, client.name)
          end
          return table.concat(buf_client_names, ", ")
        end,
        icon = "",
      },
      "encoding",
      "fileformat",
      "filetype",
    }

    -- Progress percentage
    opts.sections.lualine_y = { "progress" }

    -- Line:column info (no clock)
    opts.sections.lualine_z = { "location" }

    return opts
  end,
}
