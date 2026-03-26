# lib/sti/plugins/box2d.lua

Status: STI plugin updated with diagnostics annotation.

## Summary
- Added top-level diagnostics directive:
  - `---@diagnostic disable: undefined-field`
- Runtime plugin behavior is unchanged.
- Box2D object creation and fixture mapping from Tiled data remains intact.

## Impact
- Suppresses non-runtime editor warnings for cleaner plugin maintenance.
