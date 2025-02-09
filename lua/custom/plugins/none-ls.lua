return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier, -- For JS/TS formatting
        null_ls.builtins.formatting.stylua,   -- For Lua formatting
      },
    })

    -- Map <leader>f to format
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "[F]ormat buffer" })
  end,
}

