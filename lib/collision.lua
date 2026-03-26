local bump = require("lib.bump")

local Collision = {}

function Collision:newWorld()
  return bump.newWorld()
end

function Collision:move(world, entity, x, y)
  return world:move(entity, x, y)
end

return Collision
