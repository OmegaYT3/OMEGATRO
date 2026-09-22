SMODS.Font({
    key = 'comic_sans',
    path = 'Comic Sans.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.5,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = -100}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,            -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

SMODS.Font({
    key = 'pusab',
    path = 'PUSAB.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.7,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = 0}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,            -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

SMODS.Font({
    key = 'birthlong',
    path = 'Birthlong.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.7,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = 0}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,            -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

SMODS.Font({
    key = 'satisfontory',
    path = 'Satisfontory.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.7,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = -10}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.08,            -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

SMODS.Font({
    key = 'luckiestguy',
    path = 'LuckiestGuy.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.7,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = -10}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,            -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

SMODS.Font({
    key = 'emoji',
    path = 'Symbola.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.7,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = -10}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,            -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

SMODS.Font({
    key = 'times',
    path = 'times.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.7,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = -10}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,            -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

SMODS.Font({
    key = 'renogare',
    path = 'Renogare.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.7,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = -10}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,            -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

SMODS.Font({
    key = 'wingdings',
    path = 'Wingdings.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.7,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = -10}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,            -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

OmegaLabubu = OmegaLabubu or { count = 0 }

SMODS.Sound{
    key = "music_labubu",
    path = "music_labubu.ogg",
    volume = 1.0,
    pitch = 1.0,
    -- called each frame: return a number > 0 to request this track to be played
    select_music_track = function(self)
        if OmegaLabubu.count and OmegaLabubu.count > 0 then
            -- return a high priority so it wins over vanilla tracks
            return 1000 + OmegaLabubu.count
        end
        -- returning nil -> don't play this track
    end,
}

SMODS.current_mod.optional_features = {
    retrigger_joker = true,
	cardareas = { deck = true }
    }

SMODS.load_file("items/menu.lua")()
SMODS.load_file("items/suit_and_rarity.lua")()
SMODS.load_file("items/jokers.lua")()
SMODS.load_file("items/consumables.lua")()
SMODS.load_file("items/enchancers.lua")()
SMODS.load_file("items/decks.lua")()
SMODS.load_file("items/boosters.lua")()
SMODS.load_file("items/vouchers.lua")()