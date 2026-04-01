# core/world/map_database.lua

## Purpose

Static map adjacency and visual metadata table used by the map manager.

## Current Behavior

- Defines map records keyed by map id.
- Includes per-map `id`, `color`, and directional `neighbors`.
- Provides a center map connected to north/south/east/west neighbors.

## Data Shape

Each map entry follows:

- `id`: unique map identifier
- `color`: RGB table used for background rendering
- `neighbors`: keyed links such as `north`, `south`, `east`, `west`

## Notes

- Serves as the source of truth for movement between maps.
- Consumed by `core/world/map_manager.lua`.
