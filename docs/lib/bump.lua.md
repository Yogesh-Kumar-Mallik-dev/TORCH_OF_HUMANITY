# lib/bump.lua

Status: third-party library integrated with diagnostics annotation update.

## Summary
- Retains bump v3.1.7 collision implementation.
- Added Lua diagnostics suppression for a typed table assignment site:
  - `---@diagnostic disable-next-line: param-type-mismatch`
- Change targets editor/static-analysis noise without altering runtime behavior.

## Impact
- Reduces false-positive diagnostics while preserving collision logic.
