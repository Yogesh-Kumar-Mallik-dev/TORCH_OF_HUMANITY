# lib/animation.lua

Status: Project wrapper for third-party library

## Summary
- Wrapper module around anim8 library
- Provides simplified API for project-specific animation usage
- Abstracts grid creation and animation instantiation

## API
- `Animation:new(grid, frames, duration)` - Create animation from grid and frame sequence

## Purpose
- Standardized animation interface across project
- Decouples anim8 implementation details from game code
- Enables future animation system enhancements

## Dependencies
- `lib.anim8` - Core animation framework

## Impact
- Simplifies animation creation for entities
- Allows for consistent animation lifecycle management
