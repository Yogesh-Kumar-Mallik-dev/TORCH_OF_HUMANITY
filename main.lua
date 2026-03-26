local Game = require("core.game")

function love.load()
  Game:load()
end

function love.update(dt)
  Game:update(dt)
end

function love.draw()
  Game:draw()
end

function love.keypressed(key)
  Game.input:keypressed(key)
end

function love.keyreleased(key)
  Game.input:keyreleased(key)
end