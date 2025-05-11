return {
  {
    "pmizio/typescript-tools.nvim",
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
    },
    opts = {},
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
  },
}
