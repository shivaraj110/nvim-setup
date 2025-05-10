return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "prettier" } })
        end,
        desc = "Format Document (Force Prettier)",
      },
    },
    -- This completely replaces LazyVim's default conform configuration
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
      -- Define formatters here
      formatters_by_ft = {
        -- Lua
        lua = { "stylua" },

        -- Web development
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },

        -- Python
        python = { "isort", "black" },

        -- Add more as needed based on your file types
      },

      -- Configure formatters
      formatters = {
        -- Configure formatters here
        prettier = {
          prepend_args = { "--print-width", "100" },
        },
        stylua = {
          prepend_args = { "--indent-type", "spaces", "--indent-width", "2" },
        },
      },

      -- Format on save settings
      format_on_save = function(bufnr)
        -- Don't format on save for certain files
        local exclude_filetypes = { "text" }
        if vim.tbl_contains(exclude_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,

      -- Logging for debugging
      log_level = vim.log.levels.DEBUG,
    },
    -- Optional: Force installation of formatters when LazyVim loads
    config = function(_, opts)
      require("conform").setup(opts)

      -- This ensures the formatters are available
      -- Add any formatters you need here
      require("mason-registry").refresh(function()
        for _, formatter in ipairs({ "prettier", "stylua", "black", "isort" }) do
          local p = require("mason-registry").get_package(formatter)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
