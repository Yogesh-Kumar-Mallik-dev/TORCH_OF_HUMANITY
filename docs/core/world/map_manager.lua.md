# core/world/map_manager.lua

## Purpose

Runtime map-loading and transition manager that tracks the active map and a nearby loaded set.

## Current Behavior

- Stores the map database reference and current map id.
- Loads a start map and refreshes loaded maps around it.
- Maintains a loaded map cache keyed by map id.
- Moves between maps via directional neighbor lookup.
- Draws map background color from active map metadata.
- Prints debug information for current and loaded maps.

## API

- `MapManager.new(map_database)`
- `MapManager:load_start(map_id)`
- `MapManager:refresh()`
- `MapManager:move(direction)`
- `MapManager:draw_background()`
- `MapManager:draw()`

## Dependencies

- `engine.direction`

## Notes

- Neighbor traversal is direction-name based (north/south/east/west).
- Refresh preloads center map plus first-layer neighbors and their immediate neighbors.
