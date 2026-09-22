SMODS.Atlas{
    key = 'crafting_voucher',
    path = 'crafting_voucher.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'omega_voucher',
    path = 'omega_voucher.png',
    px = 71,
    py = 95
}

local crafting_voucher = SMODS.Voucher{
    key = "crafting_voucher",
	unlocked = true,
	discovered = true,
	cost = 10,
    atlas = "crafting_voucher",
	
	loc_txt = {
        name = "Crafting",
        text = {
            "{C:attention}Greg Packs{} start appearing",
			"Creates a {C:attention}Crafting Table{}"
        }
    },
	
	redeem = function(self, card)
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('timpani', 1, 0.4)
					SMODS.add_card({ key = "c_omega_crafting_table" })
					return true
				end
			}))
	end
}

local omega_voucher = SMODS.Voucher{
    key = "omega_voucher",
	unlocked = true,
	discovered = true,
	cost = 20,
    atlas = "omega_voucher",
	
	loc_txt = {
        name = "Omega Catalog",
        text = {
            "{C:attention}Omega Packs{} start appearing"
        }
    }
}