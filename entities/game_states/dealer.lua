local DealerState = {}

function DealerState:new(game)
    local obj = {
        game = game
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function DealerState:enter()
    local game = self.game

    -- Reveal dealer's hidden card
    if #game.dealer.hand > 0 then
        game.dealer.hand[1]:flipUp()
    end

    -- Dealer logic: hit until 16, stand on 17+
    while game.dealer:getHandValue() < 17 do
        game.dealer:addCard(game.deck:drawCard():flipUp())

        if game.dealer:isBusted() then
            print("Dealer busted!")
            break
        end
    end

    print("Dealer finished")

    game.state_machine:changeState("finishing")
end

function DealerState:draw()
end

function DealerState:keypressed(key)
end

return DealerState
