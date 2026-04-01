local Camera = {}
Camera.__index = Camera

function Camera.new()
    return setmetatable({
        x = 0,
        y = 0,
        smooth_speed = 8
    }, Camera)
end

-- =============================
-- Smooth follow (NO CLAMP)
-- =============================

function Camera:follow(player, dt)
    local target_x = player.position.x
    local target_y = player.position.y

    local t = math.min(self.smooth_speed * dt, 1)

    self.x = self.x + (target_x - self.x) * t
    self.y = self.y + (target_y - self.y) * t
end

-- =============================
-- Apply transform
-- =============================

function Camera:apply()
    love.graphics.push()

    local vw = love.graphics.getWidth()
    local vh = love.graphics.getHeight()

    love.graphics.translate(
        -self.x + vw / 2,
        -self.y + vh / 2
    )
end

function Camera:clear()
    love.graphics.pop()
end

return Camera