local PlayingState = {}
function PlayingState:new(game)
    local obj = {
        game = game
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function PlayingState:enter()
end

function PlayingState:draw()
    local startPos = 400
    love.graphics.print("H: to hit (request card)", startPos, 50)
    love.graphics.print("S: to stand (stop and go to next phase)", startPos, 60)
    love.graphics.print("R: to surrender (rollback half of the bet)", startPos, 70)
end

function PlayingState:keypressed(key)
    local game = self.game

    if key == "h" then
        game.player:addCard(game.deck:drawCard():flipUp())

        if game.player:isBusted() then
            game.state_machine:changeState("finishing", game)
        end
    end

    if key == "s" then
        print("Finished. Stand")
        game.state_machine:changeState("dealer", game)
    end

    if key == "r" then
        print("Surrender")
    end
end

return PlayingState
