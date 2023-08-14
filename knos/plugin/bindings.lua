local wezterm = require("wezterm")
local module = {}

function module.apply_to_config (config)
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
  end
end

return module
