# core/game.lua

## Purpose

Primary game orchestration module implementing load/update/draw lifecycle hooks
used by main runtime callbacks.

## Current Behavior

- Configures window title, size, fullscreen, and vsync from Config.
- Initializes input system through `engine.input`.
- Loads key bindings using `core.keybindings`.
- Creates a `Player` entity positioned at the center of the current window.
- Initializes map systems through `core.world.map_manager` and `core.world.map_database`.
- Loads starting map and renders active map background color each frame.
- Updates player simulation each frame with input and delta time.
- Performs automatic map transitions when player crosses screen bounds.
- Draws the player each frame during render pass.
- Draws map-manager debug data for current/loaded map visibility.

## API

- `Game:load()`
- `Game:update(dt)`
- `Game:draw()`

## Dependencies

- `config`
- `engine.input`
- `core.keybindings`
- `entity.player.player`
- `core.world.map_manager`
- `core.world.map_database`
- `engine.direction`

## Impact

- Extends runtime orchestration with functional map loading, transitions, and
  per-map background rendering while keeping player lifecycle integration.
