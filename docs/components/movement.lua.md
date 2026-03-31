# components/movement.lua

## Purpose

Movement component implementing directional movement, dash behavior, control-state overrides, and facing updates for entities.

## Dependencies

- `engine.vector2`
- `engine.direction`
- `engine.signal`

## Constructor

### `Movement.new(config)`
Initializes movement parameters from config:

- `max_speed`, `acceleration`, `friction`
- Dash parameters (`dash_speed`, `dash_time`, `dash_cooldown`)
- Control flags (`stunned`, `frozen`) and knockback state
- `facing_signal` for movement/facing state notifications

## Control API

- `apply_stun(state)`
- `apply_freeze(state)`
- `apply_knockback(dir, force, duration)`

Control states are applied with priority over normal movement logic.

## Direction and Input

### `get_input_direction(input)`
Builds 8-way movement direction from action inputs:

- `move_up`, `move_down`, `move_left`, `move_right`
- Opposing directions cancel each other
- Returns Vector2 directional constants or zero vector

## Update Flow

### `update(entity, input, dt)`
Per-frame update pipeline:

1. Read input direction.
2. Apply control priority:
- frozen/stunned: stop movement and emit state.
- knockback: apply knockback velocity and facing.
3. Handle dash cooldown and trigger (`dash` action).
4. Execute dash or standard movement with acceleration/friction.
5. Clamp non-dash velocity to max speed.
6. Apply position integration.
7. Update facing from velocity.
8. Emit state and facing through `facing_signal`.

## Emitted States

- `idle`
- `moving`
- `dashing`
- `knockback`
- `frozen`
- `stunned`

## Notes

- Designed for tile-scaled movement values supplied by config.
- Uses signal-based state emission to keep movement consumers decoupled.
