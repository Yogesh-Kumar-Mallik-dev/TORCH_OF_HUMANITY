# lib/sti/atlas.lua

Status: STI utility module with diagnostics annotation update.

## Summary
- Added top-level diagnostics directive:
  - `---@diagnostic disable: undefined-global`
- No algorithmic change to atlas packing behavior.
- Maintains existing texture atlas creation flow for STI image collections.

## Impact
- Improves editor diagnostics signal without changing runtime output.
