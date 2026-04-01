return {
    center = {
        id = "center",
        color = {0.2, 0.2, 0.2}, -- dark gray
        neighbors = {
            north = "north",
            south = "south",
            east  = "east",
            west  = "west",
        }
    },

    north = {
        id = "north",
        color = {0.2, 0.4, 1}, -- blue
        neighbors = {
            south = "center"
        }
    },

    south = {
        id = "south",
        color = {0.2, 1, 0.4}, -- green
        neighbors = {
            north = "center"
        }
    },

    east = {
        id = "east",
        color = {1, 0.4, 0.2}, -- orange
        neighbors = {
            west = "center"
        }
    },

    west = {
        id = "west",
        color = {1, 0.2, 0.6}, -- pink
        neighbors = {
            east = "center"
        }
    },
}