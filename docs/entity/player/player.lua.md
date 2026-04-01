# entity/player/player.lua

## Purpose

Player entity module that encapsulates player state, movement integration, and rendering logic.

## Constructor

`Player.new(x, y, movement_config)` creates a player instance at position (x, y) with optional movement configuration.

## State and Properties

- `position`: Vector2 current world position
- `velocity`: Vector2 current velocity
- `facing`: Direction facing value (influences rendered direction indicator)
- `state`: String state name updated via movement signal (e.g., "idle")
- `config`: Movement/render configuration reference used for size-driven drawing
- `movement`: Movement component instance that drives physics and facing changes

## Signal Integration

- Listens to `movement.facing_signal` to synchronize state and facing when movement emits direction changes
- Uses `on_facing_changed(sender, state, facing)` callback to update player state and direction

## API

### `Player:update(input, dt)`
Called each frame to update movement component with input and delta time.

### `Player:draw()`
Renders the player using config-driven size (`config.size` fallback 16), draws a scaled direction indicator line, and prints debug state/facing text relative to player size.

## Dependencies

- `engine.vector2`
- `engine.direction`
- `components.movement`

## Notes

- Player inherits movement behavior and physics from the Movement component.
- Facing direction is visual and controlled by the Movement component's signal emission.
