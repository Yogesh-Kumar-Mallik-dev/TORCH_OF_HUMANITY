local anim8 = require("lib.anim8")

local Animation = {}

function Animation:new(grid, frames, duration)
  return anim8.newAnimation(grid(frames), duration)
end

return Animation
