# main.lua

Status: runtime bootstrap wired.

## Summary
- Added LÖVE entry wiring to `core.game`.
- Implemented lifecycle callbacks:
	- `love.load()` -> `Game:load()`
	- `love.update(dt)` -> `Game:update(dt)`
	- `love.draw()` -> `Game:draw()`
- Routed input callbacks to game input subsystem:
	- `love.keypressed(key)` -> `Game.input:keypressed(key)`
	- `love.keyreleased(key)` -> `Game.input:keyreleased(key)`

## Impact
- Activates game loop and input dispatch through the core game module.
