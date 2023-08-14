local wezterm = require("wezterm")
local module = {}
local path = ...

function module.apply_to_config (config)
  local knos = require (path .. ".knos")
  knos.apply_to_config (config)
end

return module
