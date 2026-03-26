# lib/anim8.lua

Status: Third-party library integrated

## Summary
- **anim8** v2.3.1 - An animation library for LÖVE (Love2D framework)
- Provides grid-based frame animation system
- Open source - MIT/X11 license by Enrique García Cota
- Handles sprite sheet parsing and animation frame management

## Features
- Grid-based sprite sheet support with automatic frame generation
- Animation management with customizable frame duration
- Flip and rotation support for sprites
- Frame deceleration/interpolation capabilities
- Clone animations for instance reuse

## Components
- `Grid`: Manages sprite grid layout and frame extraction
- `Animation`: Handles animation playback, timing, and state

## Impact
- Enables sprite-based character and object animations
- Foundation for visual polish and game feedback
- Supports all animation types (idle, walk, attack, etc.)

## Integration Notes
- Wrapped in `lib/animation.lua` for project-specific API
- Used by character controllers and visual entities
