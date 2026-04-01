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
  self.state  = "idle"

  -- ✅ store config locally (important)
  self.config = movement_config

  self.movement = Movement.new(movement_config)

  -- connect signal
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
  --  use config-driven size
  local size = self.config.size or 16
  local half = size / 2

  -- Body
  love.graphics.rectangle(
    "fill",
    self.position.x - half,
    self.position.y - half,
    size,
    size
  )

  -- Facing direction
  local dir = Direction.vector(self.facing)

  if dir and not dir:is_zero() then
    love.graphics.line(
      self.position.x,
      self.position.y,
      self.position.x + dir.x * size,
      self.position.y + dir.y * size
    )
  end

  -- Debug text
  love.graphics.print(
    self.state .. " | " .. Direction.name(self.facing),
    self.position.x - size,
    self.position.y - size
  )
end

return Player