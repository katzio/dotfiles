return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Continue" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },


      { "<F6>", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    },
    config = function()
      local dap = require("dap")
      -- Rust configuration
      dap.configurations.rust = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
      program = function()
        local function find_workspace_root()
          local dir = vim.fn.getcwd()
          while dir ~= '/' do
            local cargo_toml = dir .. '/Cargo.toml'
            if vim.fn.filereadable(cargo_toml) == 1 then
              local lines = vim.fn.readfile(cargo_toml)
              for _, line in ipairs(lines) do
                if line:match('%[workspace%]') then
                  return dir
                end
              end
            end
            dir = vim.fn.fnamemodify(dir, ':h')
          end
          return vim.fn.getcwd()
        end
        local workspace_root = find_workspace_root()
        local cargo_toml = vim.fn.getcwd() .. '/Cargo.toml'
        if vim.fn.filereadable(cargo_toml) == 1 then
          local lines = vim.fn.readfile(cargo_toml)
          for _, line in ipairs(lines) do
            local name = line:match('name = "([^"]+)"')
            if name then
              return workspace_root .. '/target/debug/' .. name
            end
          end
        end
        return vim.fn.input('Path to executable: ', workspace_root .. '/target/debug/', 'file')
      end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Eval" },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>dcc", function() require("telescope").extensions.dap.configurations{} end, desc = "Configurations" },
      { "<leader>dcl", function() require("telescope").extensions.dap.list_breakpoints{} end, desc = "List Breakpoints" },
      { "<leader>dv", function() require("telescope").extensions.dap.variables{} end, desc = "Variables" },
      { "<leader>df", function() require("telescope").extensions.dap.frames{} end, desc = "Frames" },
    },
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
}