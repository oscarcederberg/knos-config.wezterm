local wezterm = require ("wezterm")
local module = {}

-- Apply Functions

local function apply_appearance (config)
  config.color_scheme = 'Gruvbox Dark (Gogh)'
  config.font = wezterm.font_with_fallback ({
    "Noto Sans Mono",
    "Noto Color Emoji"
  })

  config.inactive_pane_hsb = {
    saturation = 0.75,
    brightness = 0.66,
  }

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
      key = 'r', mods = 'SHIFT|ALT',
      action = action.Multiple ({
        action.ReloadConfiguration,

        wezterm.action_callback (function (_, _)
          wezterm.plugin.update_all ()
        end),
      })
    },
    {
      key = 'l', mods = 'SHIFT|ALT',
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
      key = 'UpArrow', mods = 'SHIFT|ALT',
      action = action.ScrollByLine(-1)
    },
    {
      key = 'DownArrow', mods = 'SHIFT|ALT',
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
      key = '\\',
      mods = 'CTRL',
      action = action.SplitVertical {},
    },
    {
      key = '|',
      mods = 'SHIFT|CTRL',
      action = action.SplitHorizontal {},
    },
    {
      key = 'q',
      mods = 'CTRL',
      action = action.CloseCurrentPane { confirm = false },
    },
    {
      key = 's',
      mods = 'SHIFT|CTRL',
      action = action.PaneSelect {
        alphabet = '1234567890',
        mode = 'SwapWithActive',
      },
    },
    {
      key = 'Tab',
      mods = 'CTRL',
      action = action.ActivatePaneDirection('Next'),
    },
    {
      key = 'Tab',
      mods = 'SHIFT|CTRL',
      action = action.ActivatePaneDirection('Prev'),
    },
    {
      key = 'f',
      mods = 'CTRL',
      action = action.TogglePaneZoomState,
    },
    {
      key = 't',
      mods = 'ALT',
      action = action.SpawnTab 'CurrentPaneDomain',
    },
    {
      key = 'q',
      mods = 'ALT',
      action = action.CloseCurrentTab { confirm = true },
    },
    {
      key = 'r',
      mods = 'ALT',
      action = action.PromptInputLine {
        description = 'enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
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

  for _, direction in pairs({'Left', 'Up', 'Right', 'Down'}) do
    table.insert(config.keys, {
        key = string.format('%sArrow', direction),
        mods = 'CTRL',
        action = action.ActivatePaneDirection(direction),
      }
    )

    table.insert(config.keys, {
        key = string.format('%sArrow', direction),
        mods = 'SHIFT|CTRL',
        action = action.AdjustPaneSize {direction, 1},
      }
    )
  end

  for i = 1, 8 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = 'ALT',
      action = action.ActivateTab(i - 1),
    })

    table.insert(config.keys, {
      key = tostring(i),
      mods = 'CTRL|ALT',
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
