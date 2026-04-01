# core/camera.lua

## Purpose

Minimal world camera utility that follows a target and applies/removes a world-to-screen transform.

## Current Behavior

- Stores camera world position (`x`, `y`).
- Stores configurable smooth follow speed (`smooth_speed`).
- Follows a target with dt-scaled interpolation toward `player.position`.
- Applies transform by translating the world so camera center aligns to screen center.
- Clears transform by restoring graphics stack.

## API

- `Camera.new()`
- `Camera:follow(player, dt)`
- `Camera:apply()`
- `Camera:clear()`

## Dependencies

- LÖVE graphics APIs: `love.graphics.push`, `love.graphics.translate`, `love.graphics.pop`, `love.graphics.getWidth`, `love.graphics.getHeight`

## Notes

- Intended for world-space drawing before UI/debug overlays.
- Follow behavior is intentionally unclamped and uses screen center as anchor.
