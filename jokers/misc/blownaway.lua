SMODS.Joker {
    key = "blownaway",
    -- loc_txt = {
    --     name = "Blown Away",
    --     text = {
    --         "If played hand contains a",
    --         "{C:attention}Straight{}, destroy highest",
    --         "scoring card and reduce",
    --         "blind by {C:attention}#1#%{}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.blind_reduce * 100
            }
        }
    end,
    config = {
        extra = {
            blind_reduce = 0.1
        }
    },
    atlas = "jokers_atlas",
    pos = {x=13,y=REND.atlas_y.misc[1]},
    rarity = 3,
    cost = 7,
    calculate = function(self,card,context)
        if context.before and context.cardarea == G.jokers then
            if (#context.poker_hands["Straight"] > 0) then
                local create_champion_event = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.8,
                        func = function()
                            if G.hand_text_area.blind_chips then
                                local new_chips = math.floor(G.GAME.blind.chips * (1-card.ability.extra.blind_reduce))
                                local mod_text = number_format(math.floor(G.GAME.blind.chips * (1-card.ability.extra.blind_reduce)-G.GAME.blind.chips))
                                G.GAME.blind.chips = new_chips
                                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                                local chips_UI = G.hand_text_area.blind_chips
                                G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                                G.HUD_blind:recalculate()
                                attention_text({
                                    text = mod_text,
                                    scale = 0.8,
                                    hold = 0.7,
                                    cover = chips_UI.parent,
                                    cover_colour = G.C.RED,
                                    align = 'cm'
                                })
                                chips_UI:juice_up()
                                play_sound('chips2')
                            else
                                return false
                            end
                            return true
                        end
                    }))
                end
                create_champion_event()
            end
        end
        
        if context.destroy_card and context.cardarea == G.play and #context.poker_hands["Straight"] > 0 then
            local temp_ID = 0
            local highest_card = nil
            
            local low_ace = false
            for i=1, #G.play.cards do
                if G.play.cards[i].base.id < 6 and not SMODS.has_no_rank(G.play.cards[i]) then 
                    low_ace = true
                end
            end
            for i=1, #G.play.cards do
                local check_id = ((low_ace and G.play.cards[i].base.id == 14) and 1) or G.play.cards[i].base.id
                if temp_ID <= check_id and not SMODS.has_no_rank(G.play.cards[i]) then 
                    temp_ID = check_id
                    highest_card = G.play.cards[i]
                end
            end
            if (context.destroy_card == highest_card) then
                return {
                    remove = true
                }
            end
        end
    end,
    blueprint_compat = true, -- Work on this some more in the future to make it destroy more cards in sequence
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end
}