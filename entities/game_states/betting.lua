local BettingState = {}
function BettingState:new(game)
    local obj = {
        game = game
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function BettingState:draw()
    love.graphics.print("APOSTA - Clique para confirmar", 100, 100)
end

function BettingState:enter()
    local game = self.game
    game.player.bet = 100

    game.player:addCard(game.deck:drawCard():flipUp())
    game.dealer:addCard(game.deck:drawCard():flipUp())
    game.player:addCard(game.deck:drawCard():flipUp())
    game.dealer:addCard(game.deck:drawCard())

    game.state_machine:changeState("playing", game)
end

return BettingState
