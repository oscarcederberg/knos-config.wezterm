local module = {}

function module.apply_to_config (config)
  local color = require 'knos.color'
  local key = require 'knos.key'
  local set = require 'knos.set'

  color.apply_to_config (config)
  key.apply_to_config (config)
  set.apply_to_config (config)
end

return module
