local FinishingState = {}
function FinishingState:new(game)
    local obj = {
        game = game
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function FinishingState:enter()
    print("finishing entering")

    local game = self.game
    local playerValue = game.player:getHandValue()
    local dealerValue = game.dealer:getHandValue()

    -- Show all cards
    for _, card in ipairs(game.dealer.hand) do
        card:flipUp()
    end

    -- Determine winner
    if playerValue > 21 then
        print("Player busts! Dealer wins.")
    elseif dealerValue > 21 then
        print("Dealer busts! Player wins.")
    elseif playerValue > dealerValue then
        print("Player wins!")
    elseif playerValue < dealerValue then
        print("Dealer wins!")
    else
        print("Push (tie)!")
    end
end

function FinishingState:draw()
end

function FinishingState:keypressed(key)
end

return FinishingState
