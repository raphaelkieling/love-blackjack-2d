local love = require "love"

Card = {
    suit = "",  -- "hearts", "diamonds", "clubs", "spades"
    value = "", -- "A", "2", ..., "10", "J", "Q", "K"
    x = 0,      -- Posição na tela
    y = 0,
    faceUp = false,
    sprite = nil
}

function Card:new(suit, value)
    local obj = {
        suit = suit,
        value = value,
        faceUp = false,
        w = 50,
        h = 70
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Card:flipUp()
    self.faceUp = true
    return self
end

function Card:load()
    self.sprite = love.graphics.newImage("cards.png")
    print("Loaded sprite")
end

function Card:getNumericValue()
    if self.value == "A" then
        return 1
    elseif self.value == "J" then
        return 11
    elseif self.value == "Q" then
        return 12
    elseif self.value == "K" then
        return 14
    else
        return tonumber(self.value)
    end
end

function Card:getFlipped()
    local quad = love.graphics.newQuad(self.w * 3, 0 * self.h, self.w, self.h, self.sprite)
    return quad
end

function Card:draw()
    if not self.faceUp then
        love.graphics.draw(self.sprite, self:getFlipped(), self.x, self.y)
        return
    end

    local x = self:getNumericValue() - 1
    local y = 1

    local quad = love.graphics.newQuad(self.w * x, y * self.h, self.w, self.h, self.sprite)
    love.graphics.draw(self.sprite, quad, self.x, self.y)
end
