SMODS.Atlas{
    key = 'fortnite',
    path = 'fortnite.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'simp',
    path = 'simp.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'infinity',
    path = 'infinity.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'tycoon',
    path = 'tycoon.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'creditcard_inbuffonpack',
    path = 'creditcard_inbuffonpack.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'negation',
    path = 'negation.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'upgrade',
    path = 'upgrade.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'greg_materials',
    path = 'greg_materials.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'crafting_table',
    path = 'crafting_table.png',
    px = 71,
    py = 95
}

local ok_sound = SMODS.Sound{
  key = "ok_sound",
  path = "ok.ogg",
}

local dollar19_card = SMODS.Consumable{
    key = "dollar19_card",
    set = "Tarot",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 19,
    atlas = "fortnite",
	loc_txt = {
        name = "19$ Dollar Fortnite Card",
        text = {
            "Okay, 19$ Dollar Fornite Card",
			"Who wants it? And yes, im giving",
			"it away. Remeber, share, share, SHARE!",
			"And trolls, DON'T GET BLOCKED!"
        }
    },

    use = function(self, card, area, copier)
        ease_dollars(19)
		play_sound("omega_ok_sound")
    end,
	
	    can_use = function(self, card)
		    return true
	end,
}

local simp_gem = SMODS.Consumable{
    key = "simp_gem",
    set = "Spectral",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 20,
    atlas = "simp",
	
	pos = {x=0, y= 0},
    soul_pos = {x=0, y= 1},
	
	loc_txt = {
        name = "SIMP Gem",
        text = {
            "Creates a {E:1,C:omega_fire,s:1.5}SIMP{} Joker"
        }
    },
	
	hidden = true,
	soul_set = 'Spectral',
	soul_rate = 0.003,
	can_repeat_soul = false,
	
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({set = "Joker", rarity = "omega_simp"})
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
	
	    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}

local infinity = SMODS.Consumable{
    key = "infinity",
    set = "Spectral",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 10,
    atlas = "infinity",
	
	loc_txt = {
        name = "Infinity",
        text = {
            "Converts up to",
			"{C:attention}3{} selected cards",
			"to {C:omega_suit}Omegas{}"
        }
    },
    config = { max_highlighted = 3, suit_conv = 'omega_suit' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, localize(card.ability.suit_conv, 'suits_plural'), colours = { G.C.SUITS[card.ability.suit_conv] } } }
    end,
}

--[[local tycoon = SMODS.Consumable{
    key = "tycoon",
    set = "Tarot",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 10,
    atlas = "tycoon",
	
	loc_txt = {
        name = "The Tycoon",
        text = {
            "Enchances {C:attention}1{} selected ",
			"card into a {C:attention}Diamond Card{}"
        }
    },
	
	
    config = { max_highlighted = 1, mod_conv = 'm_omega_diamond' },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_omega_diamond
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}  --]]

local creditcard_inbuffonpack = SMODS.Consumable{
    key = "creditcard_inbuffonpack",
    set = "Spectral",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 5,
    atlas = "creditcard_inbuffonpack",
	
	loc_txt = {
        name = "Credit Card in the Buffon Pack",
        text = {
            "Gives a free {C:attention}Blueprint{} and an",
			"{C:red}Eternal{} {C:attention}Credit Card{} {C:inactive}(must have room for both){}"
        }
    },
	
	loc_vars = function(self, info_queue, card)
	info_queue[#info_queue+1] = G.P_CENTERS.j_blueprint
	end,
	
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', key = "j_blueprint" })
				SMODS.add_card({ set = 'Joker', key = "j_credit_card", stickers={"eternal"}, force_stickers = true })
                return true
            end
        }))
        delay(0.6)
    end,
	
	can_use = function(self, card)
        return #G.jokers.cards + 1 < G.jokers.config.card_limit or card.area == G.jokers
    end
}

local negation = SMODS.Consumable{
    key = "negation",
    set = "Spectral",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 5,
    atlas = "negation",
	
	loc_txt = {
        name = "Wheel of Negation",
        text = {
            "{C:green}#1# in #2#{} chance to add {C:dark_edition}Negative{}",
			"to a random {C:attention}Joker{}"
        }
    },
	
	config = { extra = { odds = 4 } },
	
	loc_vars = function(self, info_queue, card)
	local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'omega_negation')
        return { vars = { numerator, denominator } }
	end,
	
    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, 'omega_negation', 1, card.ability.extra.odds) then
            local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)

            local eligible_card = pseudorandom_element(editionless_jokers, 'omega_negation')
            eligible_card:set_edition('e_negative', true)
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
	
	can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end
}

local upgrade = SMODS.Consumable{
    key = "upgrade",
    set = "Spectral",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 5,
    atlas = "upgrade",
	
	loc_txt = {
        name = "Upgrade",
        text = {
            "Upgrade 1 random card's {C:enhanced}enhancement{} in your hand",
			"If card has no enhancement adds a {C:gold}Star{} sticker"
        }
    },
	
use = function(self, card, area, copier)
    -- Enhancement upgrade mapping
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
    -- Upgraded enhancement keys for filtering
    local upgraded_enhancements = {}
    for _, v in pairs(upgrade_map) do upgraded_enhancements[v] = true end

    -- Pick a valid card: no star sticker, no upgraded enhancement
    local valid_cards = {}
    for _, c in ipairs(G.hand.cards) do
        local enh = c.config.center.key
        local has_star = c.ability['omega_star']

        -- Valid if: no star sticker, AND (not already upgraded enhancement)
        if not has_star and not upgraded_enhancements[enh] then
            table.insert(valid_cards, c)
        end
    end

    if #valid_cards == 0 then return end -- Nothing to do, just in case, safety

    local target_card = pseudorandom_element(valid_cards, pseudoseed('omega_upgrade'))

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('talisman_echip')
            card:juice_up(0.3, 0.5)
            return true
        end
    }))

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            local curr_enh = target_card.config.center.key
            if curr_enh and upgrade_map[curr_enh] then
                local new_enh = upgrade_map[curr_enh]
                if G.P_CENTERS[new_enh] then
                    target_card:set_ability(G.P_CENTERS[new_enh], nil, true)
                    target_card:juice_up(0.3, 0.5)
                end
            else
                SMODS.Stickers['omega_star']:apply(target_card, true)
                target_card:juice_up(0.3, 0.5)
            end

            return true
        end
    }))
end,

can_use = function(self, card)
    local upgrade_map = {
        ['m_bonus'] = true, ['m_mult'] = true, ['m_wild'] = true,
        ['m_glass'] = true, ['m_steel'] = true, ['m_stone'] = true,
        ['m_gold'] = true, ['m_lucky'] = true
    }
    local upgraded_enhancements = {
        ['m_omega_swapping'] = true, ['m_omega_scaling'] = true, ['m_omega_rainbow'] = true,
        ['m_omega_obsidian'] = true, ['m_omega_reinforced'] = true, ['m_omega_concrete'] = true,
        ['m_omega_diamond'] = true, ['m_omega_rigged'] = true
    }

    if not G.hand or #G.hand.cards == 0 then return false end

    for _, c in ipairs(G.hand.cards) do
        local enh = c.config.center.key
        if not c.ability['omega_star'] and not upgraded_enhancements[enh] then
            return true
        end
    end

    return false
end
}

local materials = SMODS.ConsumableType{
	key = "materials",
	primary_colour = HEX "727272",
	secondary_colour = HEX "727272",
	
	loc_txt = {
        name = "Materials",
		collection = "Materials"
    },
}

local resin_cb = SMODS.Consumable{
    key = "resin_cb",
    set = "materials",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 2,
    atlas = "greg_materials",
	config = { card_limit = 1 },
	
	pos = {x= 0, y= 0},
	
	loc_txt = {
        name = "Resin Printed Circuit Board",
        text = {
            "Material for an LV Circuit"
        }
    },
	
	can_use = function(self, card)
        return false
    end
}

local resistor = SMODS.Consumable{
    key = "resistor",
    set = "materials",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 2,
    atlas = "greg_materials",
	config = { card_limit = 1 },
	
	pos = {x= 1, y= 0},
	
	loc_txt = {
        name = "Resistor",
        text = {
            "Material for an LV Circuit",
			"{C:inactive}Needs 2{}"
        }
    },
	
	can_use = function(self, card)
        return false
    end
}

local red_alloy = SMODS.Consumable{
    key = "red_alloy",
    set = "materials",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 2,
    atlas = "greg_materials",
	config = { card_limit = 1 },
	
	pos = {x= 2, y= 0},
	
	loc_txt = {
        name = "Red Alloy Cable",
        text = {
            "Material for an LV Circuit",
			"{C:inactive}Needs 3{}"
        }
    },
	
	can_use = function(self, card)
        return false
    end
}

local vaccum_tube = SMODS.Consumable{
    key = "vaccum_tube",
    set = "materials",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 2,
    atlas = "greg_materials",
	config = { card_limit = 1 },
	
	pos = {x= 3, y= 0},
	
	loc_txt = {
        name = "Vaccum Tube",
        text = {
            "Material for an LV Circuit",
			"{C:inactive}Needs 2{}"
        }
    },
	
	can_use = function(self, card)
        return false
    end
}

local steel_plate = SMODS.Consumable{
    key = "steel_plate",
    set = "materials",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 2,
    atlas = "greg_materials",
	config = { card_limit = 1 },
	
	pos = {x= 4, y= 0},
	
	loc_txt = {
        name = "Steel Plate",
        text = {
            "Material for an LV Circuit"
        }
    },
	
	can_use = function(self, card)
        return false
    end
}

local lv_circuit = SMODS.Consumable{
    key = "lv_circuit",
    set = "materials",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 10,
    atlas = "greg_materials",
	
	pos = {x= 5, y= 0},
	
	loc_txt = {
        name = "{C:red}LV{} Circuit",
        text = {
            "Creates a random",
			"{C:legendary}Legendary{} or {E:1,C:omega_fire,s:1.5}SIMP{} {C:attention}Joker{}"
        }
    },
	
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
				if SMODS.pseudorandom_probability(c_omega_lv_circuit, "monkey", 1, 2, nil, true) then
					SMODS.add_card({ set = 'Joker', rarity = 'Legendary' })
				else
					SMODS.add_card({ set = 'Joker', rarity = 'omega_simp' })
				end
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
	
	can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
    end
}

local tools = SMODS.ConsumableType{
	key = "tools",
	primary_colour = HEX "C29D62",
	secondary_colour = HEX "C29D62",
	
	loc_txt = {
        name = "Tools",
		collection = "Tools"
    },
}

local crafting_table = SMODS.Consumable{
    key = "crafting_table",
    set = "tools",
	object_type = "Consumable",
	unlocked = true,
	discovered = true,
	cost = 10,
    atlas = "crafting_table",
	config = { card_limit = 1 },
	
	loc_txt = {
        name = "Crafting Table",
        text = {
            "For crafting LV circuits"
        }
    },
	
	can_use = function(self, card)
		local required = {
			c_omega_resin_cb = 1,
			c_omega_resistor = 2,
			c_omega_red_alloy = 3,
			c_omega_vaccum_tube = 2,
			c_omega_steel_plate = 1
		}
		local found = {
			c_omega_resin_cb = 0,
			c_omega_resistor = 0,
			c_omega_red_alloy = 0,
			c_omega_vaccum_tube = 0,
			c_omega_steel_plate = 0
		}
		for _, consumable in ipairs(G.consumeables.cards) do
			if found[consumable.config.center.key] ~= nil then
				found[consumable.config.center.key] = found[consumable.config.center.key] + 1
			end
		end
		for k, v in pairs(required) do
			if found[k] < v then
				return false
			end
		end
		return true
	end,
	
	use = function(self, card, area, copier)
		local required = {
			c_omega_resin_cb = 1,
			c_omega_resistor = 2,
			c_omega_red_alloy = 3,
			c_omega_vaccum_tube = 2,
			c_omega_steel_plate = 1
		}

		local to_destroy = {}
		for key, amount in pairs(required) do
			local matches = SMODS.find_card(key)
			for i = 1, amount do
				if matches[i] then
					table.insert(to_destroy, matches[i])
				end
			end
		end

		SMODS.destroy_cards(to_destroy)

		SMODS.add_card({ key = "c_omega_lv_circuit" })
		SMODS.add_card({ key = "c_omega_crafting_table" })
	end
}