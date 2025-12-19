return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- storm, moon, night, day
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },
        on_highlights = function(hl, c)
          -- Distinct Rust colors - no merging, every element clearly separated

          -- Keywords (fn, let, if, impl, struct, enum) - Bright Purple with high contrast
          hl["@keyword"] = { fg = "#c0a0ff", italic = true }
          hl["@keyword.rust"] = { fg = "#c0a0ff", italic = true }
          hl["@keyword.function"] = { fg = "#c0a0ff", italic = true }
          hl["@keyword.return"] = { fg = "#c0a0ff", italic = true }

          -- Import keywords (use, mod) - Orange
          hl["@keyword.import"] = { fg = "#ff9e64", italic = true }

          -- Module/namespace names - Teal (distinct from cyan)
          hl["@module"] = { fg = "#2ac3de" }
          hl["@namespace"] = { fg = "#2ac3de" }

          -- Struct names - Yellow/Gold
          hl["@lsp.type.struct"] = { fg = "#e0af68" }
          hl["@lsp.type.struct.rust"] = { fg = "#e0af68" }
          hl["@lsp.typemod.struct.declaration"] = { fg = "#e0af68" }
          hl["@lsp.typemod.struct.declaration.rust"] = { fg = "#e0af68" }

          -- Trait names - Bright Cyan with italic (completely different from structs)
          hl["@lsp.type.interface"] = { fg = "#7dcfff", italic = true }
          hl["@lsp.type.interface.rust"] = { fg = "#7dcfff", italic = true }
          hl["@lsp.typemod.interface.public"] = { fg = "#7dcfff", italic = true }
          hl["@lsp.typemod.interface.public.rust"] = { fg = "#7dcfff", italic = true }

          -- Fallback for all other types
          hl["@type"] = { fg = "#e0af68" }
          hl["@type.builtin"] = { fg = "#e0af68" }
          hl["@type.rust"] = { fg = "#e0af68" }

          -- Generic type parameters - Purple/Lavender (F, T, etc)
          hl["@lsp.type.typeParameter"] = { fg = "#bb9af7" }
          hl["@lsp.type.typeParameter.rust"] = { fg = "#bb9af7" }
          hl["@type.parameter"] = { fg = "#bb9af7" }

          -- Function definitions - Bright Blue with bold
          hl["@function"] = { fg = "#7aa2f7" }
          hl["@function.builtin"] = { fg = "#7aa2f7" }

          -- Function calls - Bright Blue (no bold, lighter)
          hl["@function.call"] = { fg = "#7aa2f7" }
          hl["@method"] = { fg = "#7aa2f7" }
          hl["@method.call"] = { fg = "#7aa2f7" }
          hl["@constructor"] = { fg = "#7aa2f7" }

          -- Struct fields - Peach/Coral (distinct from all others)
          hl["@field"] = { fg = "#f7768e" }
          hl["@property"] = { fg = "#f7768e" }
          hl["@variable.member"] = { fg = "#f7768e" }

          -- Macros - Magenta (special/bold)
          hl["@function.macro"] = { fg = "#bb9af7" }
          hl["@macro"] = { fg = "#bb9af7" }
          hl["@lsp.type.macro"] = { fg = "#bb9af7" }

          -- Strings - Green (classic, distinct)
          hl["@string"] = { fg = "#9ece6a" }
          hl["@string.escape"] = { fg = "#2ac3de" }

          -- Numbers - Orange (warm, stands out)
          hl["@number"] = { fg = "#ff9e64" }
          hl["@float"] = { fg = "#ff9e64" }

          -- Lifetimes - Red/Pink (special attention)
          hl["@label"] = { fg = "#f7768e" }
          hl["@storageclass.lifetime"] = { fg = "#f7768e", italic = true }

          -- Attributes - Yellow (annotations stand out)
          hl["@attribute"] = { fg = "#e0af68" }
        end,
      })
      vim.cmd("colorscheme tokyonight-moon")

      -- Custom highlight for "std" in imports to make it italic
      vim.api.nvim_set_hl(0, "RustStdModule", { fg = "#86e1fc", italic = true })

      -- Diagnostic underlines - red underline for errors (Ghostty with xterm-256color doesn't support undercurl)
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { fg = "#f7768e", underline = true })
      vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#f7768e" })

      -- Ensure diagnostic highlights persist after LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { fg = "#f7768e", underline = true })
        end,
      })

      vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "TextChanged", "TextChangedI" }, {
        pattern = "rust",
        callback = function()
          vim.fn.matchadd("RustStdModule", "\\<std\\ze::", 10)
        end,
      })
    end,
  },
}
