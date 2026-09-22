SMODS.Atlas{
    key = 'titlescreen',
    path = 'titlescreen.png',
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
}

local titlescreen = SMODS.Joker{
    key = "titlescreen",
    loc_txt = {
        name = "titlescreen",
        text = {
            "i couldn't figure out how to put",
            "playing cards in the main menu :sob:",
            "dont buy this it does nothing"
        }
    },
    atlas = "titlescreen",
    rarity = 1,
    cost = 0,
    no_collection = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
    end
}

function Card:resize(mod, force_save)
    self:hard_set_T(self.T.x, self.T.y, self.T.w * mod, self.T.h * mod)
    remove_all(self.children)
    self.children = {}
    self.children.shadow = Moveable(0, 0, 0, 0)
    self:set_sprites(self.config.center, self.base.id and self.config.card)
end

G.C.maybeBLUE = HEX("0059FF")
G.C.maybeCYAN = HEX("009BFF")
G.C.mid_flash = 0
G.C.vort_time = 7
G.C.vort_speed = 0.4

local mainmenuref = Game.main_menu
local menu_initialized = false

Game.main_menu = function(change_context)
    local ret = mainmenuref(change_context)

    if not menu_initialized then
        menu_initialized = true

        -- Card setup
        local newcard = SMODS.create_card({key='j_omega_titlescreen', area = G.title_top})
        G.title_top.T.w = G.title_top.T.w * 1.7675
        G.title_top.T.x = G.title_top.T.x - 0.8
        G.title_top:emplace(newcard)
        newcard:start_materialize()
        newcard:resize(1.1 * 1.2)
        newcard.no_ui = true

        -- Splash back setup
        if G.SPLASH_BACK and G.SPLASH_BACK.define_draw_steps then
            G.SPLASH_BACK:define_draw_steps({
                {
                    shader = "splash",
                    send = {
                        { name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                        { name = 'vort_speed', val = G.C.vort_speed },
                        { name = 'colour_1', ref_table = G.C, ref_value = 'maybeBLUE' },
                        { name = 'colour_2', ref_table = G.C, ref_value = 'maybeCYAN' },
                        { name = 'mid_flash', ref_table = G.C, ref_value = 'mid_flash' },
                    },
                },
            })
        end
    end

    return ret
end