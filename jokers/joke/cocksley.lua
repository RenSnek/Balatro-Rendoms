SMODS.Joker {
    key = "cocksley",
    loc_txt = {
        name = "Cocksley",
        text = {
            "{C:mult}+#1#{} discards",
            "{C:chips}#2#{} hand"
        }
    },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.d_size,card.ability.extra.h_plays}
        }
    end,
    config = {
        d_size = 3,
        extra = {h_plays = -1},
    },
    atlas = "jokers_atlas",
    pos = {x=8,y=1},
    rarity = 2,
    cost = 5,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end,
    add_to_deck = function(self,card,from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.h_plays
    end,
    remove_from_deck = function(self,card,from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.h_plays
    end,
}