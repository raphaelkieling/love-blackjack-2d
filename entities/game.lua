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

function Game:reset()
    self.deck = Deck:new()
    self.deck:shuffle()

    self.player.hand = {}
    self.player.bet = 0

    self.dealer.hand = {}

    self.state_machine:changeState("betting", self)
end

function Game:update(dt)
    -- Lógica de atualização (animações, etc.)
    if self.state_machine then
        self.state_machine:update(dt)
    end

    for _, card in ipairs(self.player.hand) do
        card:update(dt)
    end

    for _, card in ipairs(self.dealer.hand) do
        card:update(dt)
    end
end

function Game:getCenterHandLocation(hand)
    return (love.graphics.getWidth() / 2) - ((#hand * 70) / 2)
end

function Game:draw()
    local playerXLocation = self:getCenterHandLocation(self.player.hand)

    -- Desenha cartas do jogador e dealer
    for i, card in ipairs(self.player.hand) do
        card.x = playerXLocation + (i - 1) * 70
        card.y = 400
        card:draw()
    end

    local dealerXLocation = self:getCenterHandLocation(self.dealer.hand)
    for i, card in ipairs(self.dealer.hand) do
        card.x = dealerXLocation + (i - 1) * 70
        card.y = 100
        card:draw()
    end

    -- Debug
    -- love.graphics.print("Player: " .. self.player:getHandValue(), 100, 370)
    -- love.graphics.print("Dealer: " .. self.dealer:getHandValue(), 100, 70)
    love.graphics.print("Player Money: " .. self.player.money, 30, 30)
    love.graphics.print("Player Bet: " .. self.player.bet, 30, 50)

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
