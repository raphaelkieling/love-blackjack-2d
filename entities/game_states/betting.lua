local BettingState = {}
function BettingState:new(game)
    local obj = {
        game = game,
        cardDealDelay = 0.2,
        currentStep = 0,
        timer = 0

    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function BettingState:enter()
    local game = self.game
    game.player.bet = 100
    game.player.money = game.player.money - 100
    self.currentStep = 1
    self.timer = 0
end

function BettingState:update(dt)
    local game = self.game

    self.timer = self.timer + dt

    if self.timer >= self.cardDealDelay then
        self.timer = 0

        if self.currentStep == 1 then
            game.player:addCard(game.deck:drawCard():flipUp())
            self.currentStep = 2
        elseif self.currentStep == 2 then
            game.dealer:addCard(game.deck:drawCard():flipUp())
            self.currentStep = 3
        elseif self.currentStep == 3 then
            game.player:addCard(game.deck:drawCard():flipUp())
            self.currentStep = 4
        elseif self.currentStep == 4 then
            game.dealer:addCard(game.deck:drawCard()) -- Carta do dealer virada para baixo
            self.currentStep = 5
        elseif self.currentStep == 5 then
            -- Todas as cartas foram distribuídas, muda para o estado de jogo
            game.state_machine:changeState("playing", game)
        end
    end
end

return BettingState
