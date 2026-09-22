SMODS.Atlas{
    key = 'diamond',
    path = 'diamond.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'swapping',
    path = 'swapping.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'scaling',
    path = 'scaling.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'rainbow',
    path = 'rainbow.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'obsidian',
    path = 'obsidian.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'reinforced',
    path = 'reinforced.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'rigged',
    path = 'rigged.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'cinder_block',
    path = 'cinder_block.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'star_sticker',
    path = 'star_sticker.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'embed_fail_card',
    path = 'embed_fail_card.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'sigil',
    path = 'sigil.png',
    px = 71,
    py = 95
}

local swapping = SMODS.Enhancement{
	key = "swapping",
	
    loc_txt = {
        name = "Swapping Card",
        text = {
            "Swaps {C:chips}Chips{} and {C:mult}Mult{}",
			"when scored"
        }
    },
	
	
	unlocked = true,
    discovered = true,

    atlas = "swapping",
	
	in_pool = function(self)
        return false
    end,
	
    calculate = function(self, card, context)
	if context.main_scoring and context.cardarea == G.play then
	return {
	swap = true,
	message = "Swap!",
	colour = G.C.PURPLE
	}
	end
end
}

local scaling = SMODS.Enhancement{
	key = "scaling",
	
    loc_txt = {
        name = "Scaling Card",
        text = {
            "This card gains {C:mult}+2{} Mult",
			"every time it scores",
			"Currently: {C:mult}+#1#{} Mult"
        }
    },
	
	config = { mult = 2 },
	
	loc_vars = function(self, info_queue, card)
        return {
		vars= {card.ability.mult or 2}
		}
    end,
	
	unlocked = true,
    discovered = true,

    atlas = "scaling",
	
	in_pool = function(self)
        return false
    end,
	
    calculate = function(self, card, context)
	if context.main_scoring and context.cardarea == G.play then
	card.ability.mult = card.ability.mult + 2
	end
	end
}

local rainbow = SMODS.Enhancement{
	key = "rainbow",
	
    loc_txt = {
        name = "Rainbow Card",
        text = {
            "Can be used as any suit",
			"{C:attention}Can't be debuffed{}"
        }
    },
	
	unlocked = true,
    discovered = true,
	any_suit = true,

    atlas = "rainbow",
	
	in_pool = function(self)
        return false
    end,
	
    calculate = function(self, card, context)
		if context.debuff_card and SMODS.has_enhancement(context.debuff_card, "m_omega_rainbow") then
		  return {
			prevent_debuff = true
		  }
		end
	end
}

local obsidian = SMODS.Enhancement{
	key = "obsidian",
	
    loc_txt = {
        name = "Obsidian Card",
        text = {
            "{X:mult,C:white}X#3#{} Mult, {C:green}#1# in #2#{} to shatter, up to 3 times",
			"before being destroyed, Adds {X:mult,C:white}X1{} Mult each shatter"
        }
    },
	
	config = { extra = { odds = 4 }, x_mult = 2 },
	loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'omega_obsidian')
        return { vars = { numerator, denominator, card.ability.x_mult } }
    end,
	
	unlocked = true,
    discovered = true,

    atlas = "obsidian",
	
	in_pool = function(self)
        return false
    end,
	
    calculate = function(self, card, context)
    -- Only triggers on context.destroy_card during play
    if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
        -- Do the shatter probability
        if SMODS.pseudorandom_probability(card, 'omega_obsidian', 1, card.ability.extra.odds) then
            -- Count shatters, initialize if hasn't yet
            card.ability.obsidian_shatters = (card.ability.obsidian_shatters or 0) + 1

            -- Add +1 xmult per shatter
            card.ability.x_mult = (card.ability.x_mult or 2) + 1

            -- If this is the third shatter, destroy the card
            if card.ability.obsidian_shatters >= 3 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        if card.sprite then card:juice_up(0.3, 0.5) end
                        play_sound('glass1')
                        return true
                    end
                }))
                return { remove = true }
            else
                -- Otherwise, DO NOT remove the card; maybe trigger a 'shatter' visual
                -- You can add a juice/sound here if you want:
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:juice_up(0.3, 0.5)
                        play_sound('glass1') -- or your own obsidian sound!
                        return true
                    end
                }))
                return {} -- don't remove the card
            end
        end
    end
end

}

local reinforced = SMODS.Enhancement{
	key = "reinforced",
	
    loc_txt = {
        name = "Reinforced Card",
        text = {
            "{X:mult,C:white}X1.5{} Mult when scored",
			"or in hand"
        }
    },
	
	config = {
		h_x_mult = 1.5,
		x_mult = 1.5,
	},
	
	unlocked = true,
    discovered = true,
	
	in_pool = function(self)
        return false
    end,

    atlas = "reinforced",
}

local cinder_block = SMODS.Enhancement{
	key = "cinder_block",
	
    loc_txt = {
        name = "Cinder Block Card",
        text = {
            "{X:chips,C:white}X1{} Chips for every {C:attention}Cinder Block Card{}",
			"in played hand"
        }
    },
	
	config = {
		x_chips = 1,
	},
	
	unlocked = true,
    discovered = true,
	replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,

    atlas = "cinder_block",
	
	in_pool = function(self)
        return false
    end,
	
    calculate = function(self, card, context)
		if context.before then
			card.ability.x_chips = 0
			for _, scored_card in ipairs(context.scoring_hand) do
				if SMODS.has_enhancement(scored_card, 'm_omega_cinder_block') then
                    card.ability.x_chips = card.ability.x_chips + 1
				end
			end
		end
	end
}

local diamond = SMODS.Enhancement{
	key = "diamond",
	
    loc_txt = {
        name = "Diamond Card",
        text = {
            "Gives {C:money}Money{} equal to the",
			"amount of {C:chips}Chips{} this card scores"
        }
    },
	
	unlocked = true,
    discovered = true,

    atlas = "diamond",
	
	in_pool = function(self)
        return false
    end,
	
    calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play and not SMODS.has_no_rank(card) then
        return { dollars = card:get_chip_bonus() } 
    end
end
}

local rigged = SMODS.Enhancement{
	key = "rigged",
	
    loc_txt = {
        name = "Rigged Card",
        text = {
            "Always gets drawn to hand"
        }
    },
	
	unlocked = true,
    discovered = true,
	pos = { x = 0, y = 0 },

    atlas = "rigged",
	
set_sprites = function(self, card, front)
  card.children.center.omega_rigged = true
end,

in_pool = function(self)
        return false
    end,
	
	calculate = function(self, card, context)
        if context.setting_blind and card.area == G.deck then
            draw_card(G.deck, G.hand, nil, 'up', true, card)
        end
    end
}

SMODS.DrawStep {
    key = "rigged",
    order = 21,
    func = function(self, layer)
        if self.children.center.omega_rigged then
            self.children.center:set_sprite_pos({ x = 0, y = 1 })
			self.children.center:draw_shader('dissolve')
			self.children.center:set_sprite_pos({ x = 0, y = 0 })
        end
    end,
    conditions = { vortex = false, facing = 'front' }
}

local star = SMODS.Sticker{
    key = "omega_star",
    loc_txt = {
        name = "Star",
        label = "Star",
        text = {
            "Upgrades card's enhancement",
            "then removes itself"
        }
    },
    atlas = "star_sticker",
    badge_colour = HEX "FFBE32",
    misc = { labels = { omega_star = 'Star'} },
    sets = { Card =  true },

    calculate = function(self, card)
        local upgrade_map = {
            ['m_bonus'] = 'm_omega_swapping',
            ['m_mult'] = 'm_omega_scaling',
            ['m_wild'] = 'm_omega_rainbow',
            ['m_glass'] = 'm_omega_obsidian',
            ['m_steel'] = 'm_omega_reinforced',
            ['m_stone'] = 'm_omega_cinder_block',
            ['m_gold'] = 'm_omega_diamond',
            ['m_lucky'] = 'm_omega_rigged'
        }
        local current_enh = card.config.center.key

        if card.ability['omega_star'] and upgrade_map[current_enh] then
    local new_enh = upgrade_map[current_enh]
    if G.P_CENTERS[new_enh] then
        card:set_ability(G.P_CENTERS[new_enh], nil, true)
        self:apply(card, false)

        -- DELAY the juice effect so it happens after animation!
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                card:juice_up(0.3, 0.5)
                play_sound('talisman_echip')
                return true
            end
        }))
    end
end
    end
}

local embed_fail = SMODS.Enhancement{
	key = "embed_fail",
	
    loc_txt = {
        name = "Embed Failure",
        text = {
            "No suit or rank",
        }
    },
	
	
	unlocked = true,
    discovered = true,
	replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,

    atlas = "embed_fail_card",
	
	in_pool = function(self)
        return false
    end
}

local sigil = SMODS.Enhancement{
	key = "sigil",
	
    loc_txt = {
        name = "sigil",
        text = {
            "No suit or rank",
			"Only scored if it's the only played card",
			"Gets destroyed at the end of round"
        }
    },
	
	
	unlocked = true,
    discovered = true,
	replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = false,

    atlas = "sigil",
	
	in_pool = function(self)
        return false
    end
}

SMODS.current_mod.calculate = function(self, context)
	if context.end_of_round then
		if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_omega_sigil') then
					playing_card:remove()
				end
			end
		end
	end
end

