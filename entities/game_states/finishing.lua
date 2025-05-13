local SoundManager = require "utils.sound"

local FinishingState = {}
function FinishingState:new(game)
    local obj = {
        game = game,
        conclusion = "",
        offsetY = 10,
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function FinishingState:enter()
    print("Entering finishing phase")

    local game = self.game
    local playerValue = game.player:getHandValue()
    local dealerValue = game.dealer:getHandValue()
    local bet = game.player.bet

    -- Reveal all dealer cards
    for _, card in ipairs(game.dealer.hand) do
        card:flipUp()
    end

    -- Check for natural blackjack (Ace + 10-value card)
    local playerBlackjack = (#game.player.hand == 2) and (playerValue == 21)
    local dealerBlackjack = (#game.dealer.hand == 2) and (dealerValue == 21)

    -- Determine outcome and handle payouts
    if playerBlackjack and not dealerBlackjack then
        SoundManager:playRewards()
        self.conclusion = "Player got Blackjack! Wins 3:2 payout"
        game.player.money = game.player.money + (bet * 2.5) -- Original bet + 1.x
    elseif dealerBlackjack and not playerBlackjack then
        self.conclusion = "Dealer got Blackjack! Player loses"
    elseif playerValue > 21 then
        self.conclusion = "Player busts! Dealer wins"
    elseif dealerValue > 21 then
        self.conclusion = "Dealer busts! Player wins"
        SoundManager:playRewards()
        game.player.money = game.player.money + (bet * 2) -- Original bet + winnings
    elseif playerValue > dealerValue then
        self.conclusion = "Player wins with higher hand"
        SoundManager:playRewards()
        game.player.money = game.player.money + (bet * 2)
    elseif playerValue < dealerValue then
        self.conclusion = "Dealer wins with higher hand"
    else
        self.conclusion = "Push (tie)! Bet returned"
        game.player.money = game.player.money + bet
        -- Money remains unchanged
    end
end

function FinishingState:update(dt)
    if self.offsetY > 0 then
        self.offsetY = self.offsetY + (0 - self.offsetY) * 10. * dt
    else
        self.offsetY = 0
    end
end

function FinishingState:draw()
    -- Draw bottom menu
    local startPos = 30
    local bottom = love.graphics.getHeight() - 30

    love.graphics.print("R: to restart", startPos, bottom - 20)

    -- Draw score
    local font = love.graphics.getFont()
    local middleY = love.graphics.getHeight() / 2
    local middleX = love.graphics.getWidth() / 2

    local score = self.game.dealer:getHandValue() .. " + " .. self.game.player:getHandValue()

    love.graphics.print(score, middleX - (font:getWidth(score) / 2), middleY + self.offsetY)
    love.graphics.print(self.conclusion, middleX - (font:getWidth(self.conclusion) / 2),
        middleY + 20 - self.offsetY)
end

function FinishingState:exit()
    self.offsetY = 30
end

function FinishingState:keypressed(key)
    if key == "r" then
        self.game:reset()
    end
end

return FinishingState
