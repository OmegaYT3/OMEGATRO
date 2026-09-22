SMODS.Atlas{
    key = 'omega_suit',
    path = 'omega_suit.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'omega_ui',
    path = 'omega_ui.png',
    px = 18,
    py = 18
}

local fire = SMODS.Gradient{
	key = "fire",
	    colours = {
        {1, 0.2, 0, 1},      -- bright red
        {1, 0.5, 0, 1},      -- orange
    },
	cycle = 10,
	interpolation = "trig"
}

local simp = SMODS.Rarity{
	key = "simp",
	loc_txt = {
		name = "SIMP"
		},
	badge_colour = fire
}

local omega_suit = SMODS.Suit{
	key = "omega_suit",
	card_key = "O",
	hc_atlas = 'omega_suit',
    lc_atlas = 'omega_suit',
    hc_ui_atlas = 'omega_ui',
    lc_ui_atlas = 'omega_ui',
	hc_colour = HEX('0026FF'),
    lc_colour = HEX('0026FF'),
	pos = { y = 0 },
    ui_pos = { x = 0, y = 0 },
	loc_txt = {
		singular = "Omega",
		plural = "Omegas"
	},
	in_pool = function(self)
        return false
    end
}