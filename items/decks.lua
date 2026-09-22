SMODS.Atlas{
    key = 'omega_deck',
    path = 'omega_deck.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'upgraded_deck',
    path = 'upgraded_deck.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'gregdeck',
    path = 'gregdeck.png',
    px = 71,
    py = 95
}

SMODS.Back {
    key = "omega_deck",
    loc_txt = {
        name = "Omega Deck",
        text = {
            "Start run with",
			"{C:attention}13{} {C:omega_suit}Omegas{} in deck",
			"Halves all {C:attention}listed{} {C:green}probabilities{}"
        }
    },
	
	atlas = "omega_deck",
    unlocked = true,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
				if v.base.suit ~= 'Clubs' then SMODS.destroy_cards(v, nil, true) else v:change_suit('omega_suit') end
			end
                return true
            end
        }))
    end,
	
	calculate = function(self, back, context)
        if context.mod_probability then
            return {
                numerator = context.numerator / 2
            }
        end
    end
}

SMODS.Back {
    key = "upgraded_deck",
    loc_txt = {
        name = "Upgraded Deck",
        text = {
            "All cards start with",
			"a {C:gold}Star{} sticker",
			"{C:red}-1{} Joker Slot"
        }
    },
	
	atlas = "upgraded_deck",
	config = { joker_slot = -1 },
    unlocked = true,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
				SMODS.Stickers['omega_star']:apply(v, true)
			end
                return true
            end
        }))
    end
}

SMODS.Back {
    key = "gregdeck",
    loc_txt = {
        name = "GregDeck",
        text = {
            "Start run with the",
			"{C:C29D62}Crafting{} voucher",
			"{C:attention}+2{} consumable slots"
        }
    },
	
	atlas = "gregdeck",
	config = { voucher = 'v_omega_crafting_voucher', consumable_slot = 2 },
    unlocked = true,
    apply = function(self, back)
    end
}