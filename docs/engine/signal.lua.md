# engine/signal.lua

Status: event signaling module created.

## Summary
- Added `Signal` class-style module with listener management and event emission.
- Added constructor `Signal.new()` with internal `listeners` registry.
- Added `connect` overloads:
  - `signal:connect(function)`
  - `signal:connect(object, method)`
- Added connection handle with `disconnect()` for targeted listener removal.
- Added `emit(sender, ...)` using a listener snapshot for safe iteration during callback changes.
- Added direct removal API `disconnect(fn)` and full reset API `clear()`.

## Impact
- Establishes a reusable decoupled event system for engine and gameplay communication.
