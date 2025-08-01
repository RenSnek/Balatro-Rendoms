SMODS.Joker {
    key = "stopsign",
    -- loc_txt = {
    --     name = "Merge Down",
    --     text = {
    --         "All cards count as {C:attention}first scored{}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.odds,card.ability.extra.permamult}
        }
    end,
    config = {
        extra = {
            permamult = 8,
            odds = 8
        }
    },
    atlas = "jokers_atlas",
    pos = {x=7,y=REND.atlas_y.joke[1]},
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            print((G.GAME.probabilities.normal or 1)/(card.ability.extra.odds))
            print(context.other_card.base.value)
            if context.other_card.base.value == "8" and pseudorandom("stopsign") < (G.GAME.probabilities.normal or 1)/(card.ability.extra.odds) then
                print("stopsign hit")
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.permamult
                return {
                    card = context.other_card,
                    message = "Upgrade!"
                }
            end
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_joke'), G.C.GREEN, G.C.WHITE, 1.2)
    end
}

-- SMODS.Joker:take_ownership('hanging_chad',
--     {
--         calculate = function(self,card,context)
--             if context.repetition then
--                 print(REND.first_card_merge_down(context.scoring_hand))
--                 if context.repetition and context.scoring_hand and REND.table_contains(REND.first_card_merge_down(context.scoring_hand),context.other_card) then
--                     print("hanging chad")
--                     return {
--                         message = localize('k_again_ex'),
--                         repetitions = self.ability.extra,
--                         card = self
--                     }
--                 end
--             end
--         end
--     },
--     true -- Suppress mod badge
-- )

