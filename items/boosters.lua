SMODS.Atlas{
    key = 'omega_pack',
    path = 'omega_pack.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'jumbo_omega_pack',
    path = 'jumbo_omega_pack.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'mega_omega_pack',
    path = 'mega_omega_pack.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'greg_pack',
    path = 'greg_pack.png',
    px = 71,
    py = 95
}

function getCard(seed)
    local cards = {}
    for i, v in pairs(G.P_CENTERS) do
        if v.set == "Joker" and v.original_mod and v.original_mod.id == "omegatro" and v.rarity ~= "omega_simp" then
            cards[#cards+1] = v
        end
    end
    return pseudorandom_element(cards, pseudoseed(seed))
end

function getMaterial(seed)
    local cards = {}
    for i, v in pairs(G.P_CENTERS) do
        if v.set == "materials" and v.key ~= "c_omega_lv_circuit" then
            cards[#cards+1] = v
        end
    end
    return pseudorandom_element(cards, pseudoseed(seed))
end

local omega_pack = SMODS.Booster{
	key = "omega_pack",
	loc_txt = {
        name = "Omega Pack",
        text = {
			"Choose {C:attention}1{} of up to",
			"{C:attention}2{} Joker's from {C:omega_suit}OMEGATRO{}"
        },
		group_name = "Omega Pack"
    },
	atlas = "omega_pack",
	
	draw_hand = false,

    config = {
        extra = 2,   -- number of cards offered
        choose = 1,  -- number player picks
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
	
	ease_background_colour = function(self)
        ease_background_colour{new_colour = HEX("0026FF"), special_colour = HEX("00FFFF")}
    end,

    weight = 0.6,
    cost = 6,
    kind = "OmegaPack",
    select_card = 'jokers',
	unlocked = true,
    discovered = true,

    create_card = function(self, card, i)
        local c = getCard("amongus")
        if c then
            local newCard = SMODS.create_card{
                key = c.key,
                skip_materialize = true
            }
            return newCard
        end
        return {key = "j_joker"}
    end,
	
	in_pool = function(self)
        return G.GAME.used_vouchers.v_omega_omega_voucher
    end
	
}

local jumbo_omega_pack = SMODS.Booster{
	key = "jumbo_omega_pack",
	loc_txt = {
        name = "Jumbo Omega Pack",
        text = {
			"Choose {C:attention}1{} of up to",
			"{C:attention}4{} Joker's from {C:omega_suit}OMEGATRO{}"
        },
		group_name = "Omega Pack"
    },
	atlas = "jumbo_omega_pack",
	
	draw_hand = false,

    config = {
        extra = 4,   -- number of cards offered
        choose = 1,  -- number player picks
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
	
	ease_background_colour = function(self)
        ease_background_colour{new_colour = HEX("0026FF"), special_colour = HEX("00FFFF")}
    end,

    weight = 0.4,
    cost = 10,
    kind = "OmegaPack",
    select_card = 'jokers',
	unlocked = true,
    discovered = true,

    create_card = function(self, card, i)
        local c = getCard("amongus")
        if c then
            local newCard = SMODS.create_card{
                key = c.key,
                skip_materialize = true
            }
            return newCard
        end
        return {key = "j_joker"}
    end,
	
	in_pool = function(self)
        return G.GAME.used_vouchers.v_omega_omega_voucher
    end
	
}

local mega_omega_pack = SMODS.Booster{
	key = "mega_omega_pack",
	loc_txt = {
        name = "Mega Omega Pack",
        text = {
			"Choose {C:attention}2{} of up to",
			"{C:attention}4{} Joker's from {C:omega_suit}OMEGATRO{}"
        },
		group_name = "Omega Pack"
    },
	atlas = "mega_omega_pack",
	
	draw_hand = false,

    config = {
        extra = 4,   -- number of cards offered
        choose = 2,  -- number player picks
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
	
	ease_background_colour = function(self)
        ease_background_colour{new_colour = HEX("0026FF"), special_colour = HEX("00FFFF")}
    end,

    weight = 0.2,
    cost = 15,
    kind = "OmegaPack",
    select_card = 'jokers',
	unlocked = true,
    discovered = true,

    create_card = function(self, card, i)
        local c = getCard("amongus")
        if c then
            local newCard = SMODS.create_card{
                key = c.key,
                skip_materialize = true
            }
            return newCard
        end
        return {key = "j_joker"}
    end,
	
	in_pool = function(self)
        return G.GAME.used_vouchers.v_omega_omega_voucher
    end
	
}

local greg_pack = SMODS.Booster{
	key = "greg_pack",
	loc_txt = {
        name = "Greg Pack",
        text = {
			"Choose {C:attention}3{} of up to",
			"{C:attention}6{} {C:default}Material{} Cards"
        },
		group_name = "Greg Pack"
    },
	atlas = "greg_pack",
	
	draw_hand = false,

    config = {
        extra = 6,
        choose = 3,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
	
	ease_background_colour = function(self)
        ease_background_colour{new_colour = HEX("2A2A28"), special_colour = HEX("6B6966")}
    end,

    weight = 1,
    cost = 4,
    kind = "GregPack",
    select_card = 'consumeables',
	unlocked = true,
    discovered = true,

    create_card = function(self, card, i)
        local c = getMaterial("amongus")
        if c then
            local newCard = SMODS.create_card{
                key = c.key,
                skip_materialize = true
            }
            return newCard
        end
        return {key = "j_joker"}
    end,
	
	in_pool = function(self)
        return G.GAME.used_vouchers.v_omega_crafting_voucher
    end
}