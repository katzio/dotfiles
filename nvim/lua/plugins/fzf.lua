return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = true, -- Load immediately to prevent conflicts with default LazyVim keybindings
  keys = {
    -- Override default space space to use fzf-lua in split
    {
      "<leader><leader>",
      function()
        -- Get current buffer's directory relative to cwd
        local current_file = vim.api.nvim_buf_get_name(0)
        local current_dir = vim.fn.fnamemodify(current_file, ":h")
        local cwd = vim.fn.getcwd()
        local relative_dir = vim.fn.fnamemodify(current_dir, ":~:.")

        -- Make sure it ends with / and doesn't start with ./
        if relative_dir ~= "." then
          relative_dir = relative_dir:gsub("^%./", "") .. "/"
        else
          relative_dir = ""
        end

        require("fzf-lua").files({
          fzf_opts = {
            ["--query"] = relative_dir,
          },
          winopts = {
            split = "belowright new", -- Opens in bottom split
            height = 0.4, -- 40% height
            width = 1.0, -- Full width
          },
        })
      end,
      desc = "Find Files (fzf)",
    },
    -- Live grep in split
    {
      "<leader>/",
      function()
        require("fzf-lua").live_grep({
          winopts = {
            split = "belowright new",
            height = 0.4,
            width = 1.0,
          },
        })
      end,
      desc = "Live Grep (fzf)",
    },
    -- Buffers
    {
      "<leader>,",
      function()
        require("fzf-lua").buffers({
          winopts = {
            split = "belowright new",
            height = 0.4,
            width = 1.0,
          },
        })
      end,
      desc = "Buffers (fzf)",
    },
    -- Find files from root
    {
      "<leader>ff",
      function()
        require("fzf-lua").files({
          winopts = {
            split = "belowright new",
            height = 0.4,
            width = 1.0,
          },
        })
      end,
      desc = "Find Files from Root (fzf)",
    },
    -- Recent files
    {
      "<leader>fr",
      function()
        require("fzf-lua").oldfiles({
          cwd_only = true,
          prompt = "Recent❯ ",
          winopts = {
            split = "belowright new",
            height = 0.4,
            width = 1.0,
          },
        })
      end,
      desc = "Recent Files (fzf)",
    },
    -- Git files
    {
      "<leader>fg",
      function()
        require("fzf-lua").git_files({
          winopts = {
            split = "belowright new",
            height = 0.4,
            width = 1.0,
          },
        })
      end,
      desc = "Git Files (fzf)",
    },
  },
  opts = {
    -- Global fzf-lua options
    winopts = {
      height = 0.4,
      width = 1.0,
      row = 1,
      col = 0,
      border = "rounded",
      preview = {
        layout = "horizontal",
        horizontal = "right:50%",
      },
    },
    keymap = {
      builtin = {
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
    files = {
      prompt = "Files❯ ",
      git_icons = true,
      file_icons = true,
      color_icons = true,
    },
    grep = {
      prompt = "Grep❯ ",
      input_prompt = "Grep For❯ ",
      git_icons = true,
      file_icons = true,
      color_icons = true,
    },
  },
}
