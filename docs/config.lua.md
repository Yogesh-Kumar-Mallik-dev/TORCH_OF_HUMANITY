# config.lua

Status: configured and initialized.

## Summary
- Added centralized `Config` module for game-wide settings.
- Defined graphics presets: `low`, `medium`, `high`, `ultra`.
- Added window, tile, title, character, world, and virtual resolution sections.
- Implemented `Config:applyPresets(preset)` to propagate scaling and derived values.
- Applied default preset with `Config:applyPresets(Config.presets.medium)`.

## Key Fields
- `Config.window`: title, resolution, fullscreen, vsync.
- `Config.tile`: base tile size, runtime scale, render size.
- `Config.title`: base font size and scaled render size.
- `Config.character`: movement constants and scaled render size.
- `Config.world`: computed visible tile counts from virtual size and tile render size.
- `Config.virtual`: fixed virtual resolution for pixel-perfect flow.

## Impact
- Establishes a single source of truth for resolution and scaling behavior.
