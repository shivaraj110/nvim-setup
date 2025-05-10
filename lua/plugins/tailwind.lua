return {
  -- Dedicated Tailwind CSS setup
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Do nothing here to avoid conflicts
    end,
    config = function(_, _)
      local lspconfig = require("lspconfig")

      -- Standalone Tailwind config
      lspconfig.tailwindcss.setup({
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
        },
        root_dir = lspconfig.util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.ts",
          "package.json",
          "node_modules",
          ".git"
        ),
        settings = {
          tailwindCSS = {
            validate = true,
            classAttributes = {
              "class",
              "className",
              "classList",
              "ngClass",
            },
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning",
            },
          },
        },
        on_attach = function(client, bufnr)
          print("Tailwind CSS server attached to buffer " .. bufnr)

          -- Debug info
          vim.api.nvim_buf_create_user_command(bufnr, "TailwindInfo", function()
            print("Tailwind CSS LSP is active on this buffer")
            print("Client ID: " .. client.id)
            print("Root directory: " .. (client.config.root_dir or "unknown"))
          end, {})
        end,
      })
    end,
  },

  -- Ensure color highlighting for Tailwind
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
}
