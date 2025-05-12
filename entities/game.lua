local StateMachine = require "utils.state_machine"

-- States
local BettingState = require "entities.game_states.betting"
local PlayingState = require "entities.game_states.playing"
local DealerState = require "entities.game_states.dealer"
local FinishingState = require "entities.game_states.finishing"

Game = {
    deck = nil,
    player = nil,
    dealer = nil,
    state_machine = StateMachine:new()
}

function Game:init()
    self.deck = Deck:new()
    self.deck:shuffle()
    self.player = Player:new()
    self.dealer = Player:new()

    self.dealer:load()
    self.player:load()

    self.
        state_machine
        :addState("betting", BettingState:new(self))
        :addState("playing", PlayingState:new(self))
        :addState("dealer", DealerState:new(self))
        :addState("finishing", FinishingState:new(self))
        :changeState("betting", self)
end

function Game:update(dt)
    -- Lógica de atualização (animações, etc.)
    if self.state_machine then
        self.state_machine:update(dt)
    end
end

function Game:draw()
    -- Desenha cartas do jogador e dealer
    for i, card in ipairs(self.player.hand) do
        card.x = 100 + (i - 1) * 70
        card.y = 400
        card:draw()
    end

    for i, card in ipairs(self.dealer.hand) do
        card.x = 100 + (i - 1) * 70
        card.y = 100
        card:draw()
    end

    -- Mostra valor da mão
    love.graphics.print("Player: " .. self.player:getHandValue(), 100, 370)
    love.graphics.print("Dealer: " .. self.dealer:getHandValue(), 100, 70)

    if self.state_machine then
        self.state_machine:draw()
    end
end

function Game:keypressed(key)
    if self.state_machine then
        self.state_machine:keypressed(key)
    end
end

function Game:mousepressed(x, y, button)
    if self.state_machine then
        self.state_machine:mousepressed(x, y, button)
    end
end
