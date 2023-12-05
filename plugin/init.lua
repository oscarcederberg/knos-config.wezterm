local wezterm = require ("wezterm")
local module = {}

local function apply_appearance (config)
  config.color_scheme = 'Gruvbox Dark (Gogh)'
  config.font = wezterm.font_with_fallback ({
    "Noto Sans Mono",
    "Noto Color Emoji"
  })

  config.window_background_opacity = 0.75

  config.use_fancy_tab_bar = false
  config.hide_tab_bar_if_only_one_tab = true
end

local function apply_bindings (config)
  local action = wezterm.action

  config.disable_default_key_bindings = true

  config.keys = {
    {
      key = 'c', mods = 'ALT',
      action = action.CopyTo 'ClipboardAndPrimarySelection'
    },
    {
      key = 'v', mods = 'ALT',
      action = action.PasteFrom 'Clipboard'
    },
    {
      key = 'r', mods = 'ALT',
      action = wezterm.action.Multiple ({
        wezterm.action.ReloadConfiguration,

        wezterm.action_callback (function (_, _)
          wezterm.plugin.update_all ()
        end),
      })
    },
    {
      key = 'L', mods = 'CTRL',
      action = action.ShowDebugOverlay
    },
    {
      key = 'PageUp', mods = 'ALT',
      action = action.ScrollByPage(-1)
    },
    {
      key = 'PageDown', mods = 'ALT',
      action = action.ScrollByPage(1)
    },
    {
      key = 'UpArrow', mods = 'ALT',
      action = action.ScrollToPrompt(-1)
    },
    {
      key = 'DownArrow', mods = 'ALT',
      action = action.ScrollToPrompt(1)
    },
    {
      key = 'UpArrow', mods = 'ALT|CTRL',
      action = action.ScrollByLine(-1)
    },
    {
      key = 'DownArrow', mods = 'ALT|CTRL',
      action = action.ScrollByLine(1)
    },
    {
      key = '=', mods = 'CTRL',
      action = action.IncreaseFontSize,
    },
    {
      key = '-', mods = 'CTRL',
      action = action.DecreaseFontSize,
    },
    {
      key = '0', mods = 'CTRL',
      action = action.ResetFontSize,
    },
    {
      key = 't',
      mods = 'ALT',
      action = action.SpawnTab 'CurrentPaneDomain',
    },
    {
      key = 'q',
      mods = 'ALT',
      action = action.CloseCurrentTab { confirm = false },
    },
    {
      key = "Tab",
      mods = 'ALT',
      action = action.ActivateTabRelative(1),
    },
    {
      key = "Tab",
      mods = 'SHIFT|ALT',
      action = action.ActivateTabRelative(-1),
    },
  }

  for i = 1, 8 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = 'ALT',
      action = action.ActivateTab(i - 1),
    })
    
    table.insert(config.keys, {
      key = tostring(i),
      mods = 'SHIFT|ALT',
      action = action.MoveTab(i - 1),
    })
  end
end

local function apply_settings (config)
  config.initial_cols = 120
  config.initial_rows = 24

  config.warn_about_missing_glyphs = false
end

function module.apply_to_config (config)
  wezterm.log_info ("applying knos-config")
  apply_appearance (config)
  apply_bindings (config)
  apply_settings (config)
end

return module
