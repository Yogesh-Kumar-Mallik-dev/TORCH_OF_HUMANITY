-- =========================================
-- CONFIG MODULE
-- Central place for all game settings
-- =========================================

local Config = {}

-- =========================================
-- GRAPHICS PRESETS
-- Controls resolution + scaling
-- =========================================
Config.presets = {
    low = {
        width = 854,
        height = 480,
        scale = 1,
    },
    medium = {
        width = 1280,
        height = 720,
        scale = 2,
    },
    high = {
        width = 1920,
        height = 1080,
        scale = 3,
    },
    ultra = {
        width = 2560,
        height = 1440,
        scale = 4,
    },
}

-- =========================================
-- WINDOW SETTINGS
-- =========================================
Config.window = {
    title = "Torch of Humanity",
    width = 0,      -- Will be set by preset
    height = 0,     -- Will be set by preset
    fullscreen = false,
    vsync = true,
}

-- =========================================
-- TILE SETTINGS (IMPORTANT: was missing before)
-- =========================================
Config.tile = {
    original_size = 16, -- Base sprite size (pixels)
    scale = 1,          -- Will be set by preset
    render_size = 16,   -- Final size after scaling
}

-- =========================================
-- TITLE TEXT SETTINGS
-- =========================================
Config.title = {
    size = 16,          -- Base font size
    scale = 1,
    render_size = 16,   -- Final scaled size
    color = {1, 1, 1},  -- RGB (white)
}

-- =========================================
-- CHARACTER SETTINGS
-- =========================================
Config.character = {
    max_speed = 200,
    acceleration = 600,
    friction = 800,
    original_size = 16,
    render_size = 16,
    scale = 1,
}

-- =========================================
-- WORLD SETTINGS
-- (Number of tiles visible in virtual resolution)
-- =========================================
Config.world = {
    tile_width = 0,
    tile_height = 0,
}

-- =========================================
-- VIRTUAL RESOLUTION (for pixel-perfect scaling)
-- =========================================
Config.virtual = {
    width = 320,
    height = 180,
}

-- =========================================
-- APPLY GRAPHICS PRESET
-- Updates all dependent values
-- =========================================
function Config:applyPresets(preset)
    -- Store current preset
    self.current = preset

    -- Set window resolution
    self.window.width = preset.width
    self.window.height = preset.height

    -- =====================
    -- TILE SCALING
    -- =====================
    self.tile.scale = preset.scale
    self.tile.render_size = self.tile.original_size * self.tile.scale

    -- =====================
    -- TITLE SCALING
    -- =====================
    self.title.render_size = self.title.size * self.tile.scale

    -- =====================
    -- CHARACTER SCALING
    -- =====================
    self.character.scale = preset.scale
    self.character.render_size = self.character.original_size * self.character.scale

    -- =====================
    -- WORLD TILE COUNT
    -- (How many tiles fit on screen)
    -- =====================
    self.world.tile_width = math.floor(self.virtual.width / self.tile.render_size)
    self.world.tile_height = math.floor(self.virtual.height / self.tile.render_size)
end

-- =========================================
-- APPLY DEFAULT PRESET (IMPORTANT: use :)
-- =========================================
Config:applyPresets(Config.presets.medium)

return Config