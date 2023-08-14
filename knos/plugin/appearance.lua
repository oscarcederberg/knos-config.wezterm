local wezterm = require("wezterm")
local module = {}

function module.apply_to_config (config)
  config.color_scheme = 'Gruvbox Dark (Gogh)'
  config.font = wezterm.font_with_fallback ({
    "Noto Sans Mono",
    "Noto Color Emoji"
  })

  config.window_background_opacity = 0.75

  config.use_fancy_tab_bar = false
  config.hide_tab_bar_if_only_one_tab = true
end

return module
