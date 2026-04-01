local Direction = require("engine.direction")

local MapManager = {}
MapManager.__index = MapManager

-- =============================
-- Constructor
-- =============================

function MapManager.new(map_database)
    local self = setmetatable({}, MapManager)

    self.database = map_database
    self.current_map_id = nil

    -- Active maps (3x3 grid)
    self.loaded = {}  -- [map_id] = map_data

    return self
end

-- =============================
-- Load Initial Map
-- =============================

function MapManager:load_start(map_id)
    self.current_map_id = map_id
    self:refresh()
end

-- =============================
-- Refresh 3x3 Grid
-- =============================

function MapManager:refresh()
    self.loaded = {}

    local center = self.database[self.current_map_id]
    if not center then return end

    self:_load_map(center.id)

    -- load neighbors (1 layer)
    for _, neighbor_id in pairs(center.neighbors) do
        if neighbor_id then
            self:_load_map(neighbor_id)

            -- load diagonals
            local neighbor = self.database[neighbor_id]
            if neighbor then
                for _, sub_id in pairs(neighbor.neighbors) do
                    if sub_id then
                        self:_load_map(sub_id)
                    end
                end
            end
        end
    end
end

-- =============================
-- Internal Load
-- =============================

function MapManager:_load_map(map_id)
    if self.loaded[map_id] then return end

    local map = self.database[map_id]
    if not map then return end

    self.loaded[map_id] = map
end

-- =============================
-- Move to New Map
-- =============================

function MapManager:move(direction)
    local current = self.database[self.current_map_id]
    if not current then return end

    local next_id = current.neighbors[Direction.name(direction)]
    if not next_id then return end

    self.current_map_id = next_id
    self:refresh()
end

-- =============================
--  DRAW BACKGROUND (NEW)
-- =============================

function MapManager:draw_background()
    local current = self.database[self.current_map_id]
    if not current then return end

    -- fallback color if missing
    local color = current.color or {0, 0, 0}

    love.graphics.setColor(color)
    love.graphics.rectangle(
        "fill",
        0,
        0,
        love.graphics.getWidth(),
        love.graphics.getHeight()
    )

    love.graphics.setColor(1, 1, 1) -- reset
end

-- =============================
-- Debug Draw
-- =============================

function MapManager:draw()
    local y = 20

    love.graphics.print("Current Map: " .. self.current_map_id, 20, y)
    y = y + 20

    for id, _ in pairs(self.loaded) do
        love.graphics.print("Loaded: " .. id, 20, y)
        y = y + 20
    end
end

return MapManager