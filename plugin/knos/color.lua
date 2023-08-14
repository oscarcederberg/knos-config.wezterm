local wezterm = require 'wezterm'
local module = {}

local function resolve_assets_path()
	for _, plugin in ipairs(wezterm.plugin.list()) do
		if plugin.url == "https://github.com/oscarcederberg/wez-knos-term" then
			return plugin.plugin_dir .. "plugin/knos/assets/"
		end
	end
end

function module.apply_to_config (config)
  local path

  config.color_scheme = 'Gruvbox Dark (Gogh)'
  config.font = wezterm.font_with_fallback ({
    "Noto Sans Mono",
    "Noto Color Emoji"
  })

  config.window_background_opacity = 0.75

  config.use_fancy_tab_bar = false
  config.hide_tab_bar_if_only_one_tab = true

  path = resolve_assets_path()
  if not path then
    wezterm.log_error ("wez-knos-config: failed to resolve assets path")
  end

  config.background = {
    {
      source = {
        File = path .. 'background.png'
      },
      repeat_x = 'NoRepeat',
      repeat_y = 'NoRepeat',
      opacity = 0.75,
      height = '100%',
      width = '100%',
    },
    {
      source = {
        File = {
          path = path .. 'subin.gif',
          speed = 1.2,
        },
      },
      attachment = 'Fixed',
      repeat_x = 'NoRepeat',
      repeat_y = 'NoRepeat',
      vertical_align = 'Bottom',
      opacity = 0.5,
      height = 48,
      width = 1440,
    }
  }
end

return module
