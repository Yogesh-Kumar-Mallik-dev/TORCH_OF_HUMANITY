local Vector2 = require("engine.vector2")
local Direction = require("engine.direction")
local Movement = require("components.movement")

local Player = {}
Player.__index = Player

-- ========================
-- Constructor
-- ========================

function Player.new(x, y, movement_config)
  local self = setmetatable({}, Player)

  self.position = Vector2.new(x or 0, y or 0)
  self.velocity = Vector2.new(0, 0)

  self.facing = Direction.facing.south
  self.state  = "idle" -- 🔥 NEW

  self.movement = Movement.new(movement_config)

  --  CONNECT SIGNAL
  self.movement.facing_signal:connect(self, self.on_facing_changed)

  return self
end

-- ========================
-- Signal Handler
-- ========================

function Player:on_facing_changed(sender, state, facing)
  self.state  = state
  self.facing = facing
end

-- ========================
-- Update
-- ========================

function Player:update(input, dt)
  self.movement:update(self, input, dt)
end

-- ========================
-- Draw
-- ========================

function Player:draw()
  -- Body
  love.graphics.rectangle(
    "fill",
    self.position.x - 10,
    self.position.y - 10,
    20,
    20
  )

  -- Facing direction
  local dir = Direction.vector(self.facing)

  if dir and not dir:is_zero() then
  love.graphics.line(
    self.position.x,
    self.position.y,
    self.position.x + dir.x * 20,
    self.position.y + dir.y * 20
  )
  end

  --  DEBUG: show state + direction
  love.graphics.print(
    self.state .. " | " .. Direction.name(self.facing),
    self.position.x - 30,
    self.position.y - 30
  )
end

return Player