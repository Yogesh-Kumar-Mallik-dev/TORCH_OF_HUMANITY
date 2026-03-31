local Vector2 = require("engine.vector2")
local Direction = require("engine.direction")
local Signal = require("engine.signal")

local Movement = {}
Movement.__index = Movement

-- ========================
-- Constructor
-- ========================
function Movement.new(config)
  local self = setmetatable({}, Movement)

  --  USE CONFIG DIRECTLY
  self.max_speed   = config.max_speed
  self.acceleration = config.acceleration
  self.friction     = config.friction

  -- Dash config
  self.dash_speed    = self.max_speed * 2.5
  self.dash_time     = 0.15
  self.dash_cooldown = 0.5

  -- Dash state
  self.dashing    = false
  self.dash_timer = 0
  self.cooldown   = 0
  self.dash_dir   = Vector2.new(0, 0)

  -- Control states
  self.control = {
    stunned = false,
    frozen = false,
    knockback = {
      active = false,
      velocity = Vector2.new(0, 0),
      timer = 0
    }
  }

  self.facing_signal = Signal.new()

  return self
end

-- ========================
-- Controls
-- ========================
function Movement:apply_stun(state)
  self.control.stunned = state
end

function Movement:apply_freeze(state)
  self.control.frozen = state
end

function Movement:apply_knockback(dir, force, duration)
  self.control.knockback.active = true
  self.control.knockback.velocity = Vector2.new(dir.x, dir.y) * force
  self.control.knockback.timer = duration
end

-- ========================
-- Input Direction (8-way)
-- ========================
function Movement:get_input_direction(input)
  local up    = input:is_action_pressed("move_up")
  local down  = input:is_action_pressed("move_down")
  local left  = input:is_action_pressed("move_left")
  local right = input:is_action_pressed("move_right")

  if up and down then up, down = false, false end
  if left and right then left, right = false, false end

  if up and right then return Vector2.UP_RIGHT
  elseif up and left then return Vector2.UP_LEFT
  elseif down and right then return Vector2.DOWN_RIGHT
  elseif down and left then return Vector2.DOWN_LEFT
  elseif up then return Vector2.UP
  elseif down then return Vector2.DOWN
  elseif right then return Vector2.RIGHT
  elseif left then return Vector2.LEFT end

  return Vector2.ZERO
end

-- ========================
-- Update
-- ========================
function Movement:update(entity, input, dt)
  local raw_dir = self:get_input_direction(input)
  local dir = Vector2.new(raw_dir.x, raw_dir.y)

  -- ========================
  -- CONTROL PRIORITY
  -- ========================

  if self.control.frozen or self.control.stunned then
    entity.velocity = Vector2.new(0, 0)
    self.facing_signal:emit(self,
      self.control.frozen and "frozen" or "stunned",
      entity.facing
    )
    return
  end

  -- Knockback
  local kb = self.control.knockback
  if kb.active then
    kb.timer = kb.timer - dt

    entity.velocity = kb.velocity
    entity.position = entity.position + entity.velocity * dt

    if kb.timer <= 0 then
      kb.active = false
    end

    local facing = Direction.from_vector(entity.velocity)
    entity.facing = facing

    self.facing_signal:emit(self, "knockback", facing)
    return
  end

  -- Dash cooldown
  if self.cooldown > 0 then
    self.cooldown = self.cooldown - dt
  end

  -- Dash trigger
  if input:is_action_just_pressed("dash") and self.cooldown <= 0 then
    self.dashing = true
    self.dash_timer = self.dash_time
    self.cooldown = self.dash_cooldown

    if not dir:is_zero() then
      self.dash_dir = dir
    else
      local f = Direction.vector(entity.facing)
      self.dash_dir = Vector2.new(f.x, f.y)
    end
  end

  local state = "idle"

  -- ========================
  -- DASH
  -- ========================
  if self.dashing then
    state = "dashing"

    self.dash_timer = self.dash_timer - dt
    entity.velocity = self.dash_dir * self.dash_speed

    if self.dash_timer <= 0 then
      self.dashing = false
    end

  else
    -- ========================
    -- NORMAL MOVEMENT
    -- ========================
    if not dir:is_zero() then
      state = "moving"

      local target_velocity = dir * self.max_speed
      local delta = target_velocity - entity.velocity
      local accel_step = self.acceleration * dt

      if delta:length() > accel_step then
        delta = delta:normalized() * accel_step
      end

      entity.velocity = entity.velocity + delta

    else
      local speed = entity.velocity:length()

      if speed > 0 then
        local drop = self.friction * dt
        speed = math.max(speed - drop, 0)

        if speed == 0 then
          entity.velocity = Vector2.new(0, 0)
        else
          entity.velocity = entity.velocity:normalized() * speed
        end
      end
    end
  end

  -- Clamp
  if not self.dashing then
    entity.velocity = entity.velocity:clamped(self.max_speed)
  end

  -- Apply movement
  entity.position = entity.position + entity.velocity * dt

  -- Facing
  if not entity.velocity:is_zero() then
    entity.facing = Direction.from_vector(entity.velocity)
  end

  self.facing_signal:emit(self, state, entity.facing)
end

return Movement