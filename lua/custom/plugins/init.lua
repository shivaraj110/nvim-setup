return {
  'andweeb/presence.nvim',
  lazy = false,
  config = function()
    require('presence').setup {
      -- General options
      auto_update = true,
      neovim_image_text = 'The One True Text Editor',
      main_image = 'neovim',
      client_id = '793271441293967371',
      log_level = nil,
      debounce_timeout = 10,
      enable_line_number = false,
      blacklist = {
        'NvimTree',
        'neo-tree',
        'dashboard',
        'Telescope',
        'lazy',
        'mason',
      },
      buttons = true,
      file_assets = {},
      show_time = true,

      -- Rich Presence text options
      editing_text = 'Editing %s like a boss',
      file_explorer_text = 'Browsing %s like a hacker',
      git_commit_text = 'Committing changes like a pro',
      plugin_manager_text = 'Managing plugins',
      reading_text = 'Reading %s',
      workspace_text = 'Working on %s',
      line_number_text = 'Line %s out of %s',
    }
  end,
}
