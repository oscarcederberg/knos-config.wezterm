local wezterm = require("wezterm")
local module = {}

function module.apply_to_config (config)
  config.initial_cols = 120
  config.initial_rows = 24

  config.warn_about_missing_glyphs = false
end

return module
