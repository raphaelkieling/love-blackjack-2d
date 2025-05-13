local SoundManager = require "utils.sound"

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
    local startPos = 30
    local bottom = love.graphics.getHeight() - 30

    love.graphics.print("Z: to hit (request card)", startPos, bottom - 20)
    love.graphics.print("X: to stand (stop and go to next phase)", startPos, bottom - 35)
    love.graphics.print("C: to surrender (rollback half of the bet)", startPos, bottom - 50)
    love.graphics.print("Q: back to menu", startPos, bottom - 65)
end

function PlayingState:playsound()
    SoundManager.playButton()
end

function PlayingState:keypressed(key)
    local game = self.game

    if key == "q" then
        TreeScene:changeScene("menu")
        return
    end

    if key == "z" then
        self:playsound()

        game.player:addCard(game.deck:drawCard():flipUp())

        if game.player:isBusted() then
            game.state_machine:changeState("finishing", game)
        end
        return
    end

    if key == "x" then
        self:playsound()

        print("Finished. Stand")
        game.state_machine:changeState("dealer", game)
        return
    end

    if key == "c" then
        self:playsound()

        print("Surrender")
        game.player.money = game.player.money + (game.player.bet / 2)
        game:reset()
    end
end

return PlayingState
