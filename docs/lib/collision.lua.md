# lib/collision.lua

Status: Project wrapper for third-party library

## Summary
- Wrapper module around bump collision library
- Provides simplified collision API for project entities
- Manages world creation and collision queries

## API
- `Collision:newWorld()` - Create new collision world
- `Collision:move(world, entity, x, y)` - Move entity and resolve collisions

## Purpose
- Standardized collision interface across project
- Abstracts bump implementation details
- Enables future collision system enhancements

## Dependencies
- `lib.bump` - Core collision detection framework

## Impact
- Simplifies physics and movement systems
- Enables character/object interaction with environment
- Foundation for hazard and interactive element behavior
