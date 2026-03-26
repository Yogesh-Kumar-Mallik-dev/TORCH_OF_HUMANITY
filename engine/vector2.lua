-- =========================================
-- VECTOR2 CLASS
-- =========================================

local Vector2 = {}
Vector2.__index = Vector2

-- =========================================
-- CONSTRUCTOR
-- Creates a new vector
-- =========================================
function Vector2.new(x, y)
    local self = setmetatable({
        x = x or 0,
        y = y or 0,
    }, Vector2)

    return self
end

-- =========================================
-- STRING REPRESENTATION
-- =========================================
function Vector2:__tostring()
    return "(" .. self.x .. ", " .. self.y .. ")"
end

-- =========================================
-- LOCK FUNCTION (IMMUTABLE VECTOR)
-- Prevents modification of vector
-- =========================================
local function lock(vector)
    return setmetatable({}, {
        __index = vector,

        __newindex = function()
            error("Attempt to modify locked Vector2")
        end,

        __tostring = function()
            return tostring(vector)
        end,
    })
end
