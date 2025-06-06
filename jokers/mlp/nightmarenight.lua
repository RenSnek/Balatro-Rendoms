SMODS.Joker {
    key = "nightmarenight",
    -- loc_txt = {
    --     name = "Nightmare Night",
    --     text = {
    --         "Played cards with",
    --         "{C:rendom_moons}Moon{} suit give",
    --         "{C:mult}+3{} Mult when scored"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
            }
        }
    end,
    config = {
    },
    atlas = "jokers_atlas",
    pos = {x=1,y=REND.atlas_y.mlp[1]},
    rarity = 1,
    cost = 5,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.suit == "rendom_moons" then
                return { mult = 3, message_card = context.other_card }
            end
        end
    end,
    blueprint_compat = true,
    in_pool = function(self,args)
        for k,card in ipairs(G.playing_cards) do
            if card:is_suit("rendom_moons") then
                return true
            end
        end
        return false
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_mlp'), G.C.PURPLE, G.C.WHITE, 1.2)
    end
}