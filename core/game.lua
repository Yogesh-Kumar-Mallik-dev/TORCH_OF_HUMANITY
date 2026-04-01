local Config = require("config")
local Input = require("engine.input")
local Keybindings = require("core.keybindings")
local Player = require("entity.player.player")
local MapManager = require("core.world.map_manager")
local MapDB = require("core.world.map_database")
local Direction = require("engine.direction")

local Game = {}

function Game:load()
    love.window.setTitle(Config.window.title)
    love.window.setMode(
        Config.window.width,
        Config.window.height,
        {
            fullscreen = Config.window.fullscreen,
            vsync = Config.window.vsync
        }
    )

    -- Input
    self.input = Input:new()
    Keybindings.load(self.input)

    -- Player (use virtual resolution!)
    self.player = Player.new(
        Config.virtual.width / 2,
        Config.virtual.height / 2,
        Config.character
    )

    -- Map system
    self.map_manager = MapManager.new(MapDB)
    self.map_manager:load_start("center")
end

function Game:update(dt)
    -- Player update
    self.player:update(self.input, dt)

    local pos = self.player.position
    local w = Config.virtual.width
    local h = Config.virtual.height
    local margin = 10 -- half player size

    -- 🔥 AUTO MAP TRANSITIONS

    -- TOP
    if pos.y < 0 then
        self.map_manager:move(Direction.facing.north)
        pos.y = h - margin
    end

    -- BOTTOM
    if pos.y > h then
        self.map_manager:move(Direction.facing.south)
        pos.y = margin
    end

    -- LEFT
    if pos.x < 0 then
        self.map_manager:move(Direction.facing.west)
        pos.x = w - margin
    end

    -- RIGHT
    if pos.x > w then
        self.map_manager:move(Direction.facing.east)
        pos.x = margin
    end

    -- Debug key (optional)
    if self.input:is_action_just_pressed("map") then
        self.map_manager:move(Direction.facing.north)
    end

    self.input:update()
end

function Game:draw()
    -- Background (map color)
    self.map_manager:draw_background()

    -- Player
    self.player:draw()

    -- Debug info
    self.map_manager:draw()
end

return Game