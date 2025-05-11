return {
  -- Core LSP setup with Mason
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason for managing LSP servers
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Optional dependencies for enhanced experience
      "folke/neodev.nvim",
      -- "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Setup Mason first
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- Configure Mason-LSPconfig integration
      require("mason-lspconfig").setup({
        -- Ensure these servers are always installed
        ensure_installed = {
          "gopls", -- Go
          "tsserver", -- TypeScript/JavaScript
          "tailwindcss", -- Tailwind CSS
          "lua_ls", -- Lua
        },
        automatic_installation = true,
      })

      -- Setup neodev for better Lua development
      require("neodev").setup()

      -- LSP server configurations
      local lspconfig = require("lspconfig")

      -- Go configuration
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
          },
        },
      })

      -- TypeScript configuration
      lspconfig.tsserver.setup({
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      })

      -- Lua configuration
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Global LSP keymaps and settings setup
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- Buffer-local keymaps
          local opts = { buffer = buffer }

          -- Navigation
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

          -- Actions
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

          -- Document formatting
          vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, opts)

          -- Diagnostics
          vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

          -- Workspace
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
        end,
      })
    end,
  },

  -- Enhanced plugins for Tailwind, TypeScript, and Go
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = true,
      },
    },
    opts = function(_, opts)
      -- Add Tailwind color preview to completion
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item)
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },

  -- Color highlighting for Tailwind
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
        mode = "background",
        css = true,
      },
    },
  },

  -- TypeScript enhanced tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    enabled = true,
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          importModuleSpecifierPreference = "relative",
          jsxAttributeCompletionStyle = "auto",
          includeCompletionsForImportStatements = true,
          includeCompletionsWithSnippetText = true,
        },
        tsserver_format_options = {
          allowIncompleteCompletions = true,
          allowRenameOfImportPath = true,
        },
      },
    },
  },

  -- Go enhancements
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
    },
    opts = {},
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
  },
}
