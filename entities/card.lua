local love = require "love"

Card = {
    suit = "",  -- "hearts", "diamonds", "clubs", "spades"
    value = "", -- "A", "2", ..., "10", "J", "Q", "K"
    x = 0,
    y = 0,
    offsetY = 30,
    faceUp = false,
    sprite = nil
}

function Card:new(suit, value)
    local obj = {
        suit = suit,
        value = value,
        faceUp = false,
        w = 50,
        h = 70,
        offsetY = 30,
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
    self.sprite = love.graphics.newImage("assets/cards.png")
    print("Loaded sprite")
end

function Card:getNumbericSuit()
    if self.suit == "hearts" then
        return 1
    end

    if self.suit == "diamonds" then
        return 2
    end

    if self.suit == "spades" then
        return 3
    end

    return 4
end

function Card:getNumericValue()
    if self.value == "A" then
        return 1
    elseif self.value == "J" then
        return 11
    elseif self.value == "Q" then
        return 12
    elseif self.value == "K" then
        return 13
    else
        return tonumber(self.value)
    end
end

function Card:getFlipped()
    local quad = love.graphics.newQuad(self.w * 3, 0 * self.h, self.w, self.h, self.sprite)
    return quad
end

function Card:getFace()
    local x = self:getNumericValue() - 1
    local y = self:getNumbericSuit()

    local quad = love.graphics.newQuad(self.w * x, y * self.h, self.w, self.h, self.sprite)
    return quad
end

function Card:update(dt)
    if self.offsetY > 0 then
        self.offsetY = self.offsetY + (0 - self.offsetY) * 10. * dt
    else
        self.offsetY = 0
    end
end

function Card:exit()
    self.offsetY = 30
end

function Card:draw()
    -- Debug stuff
    -- love.graphics.print(self.suit .. self.value, self.x, self.y - 50)
    if not self.faceUp then
        love.graphics.draw(self.sprite, self:getFlipped(), self.x, self.y + self.offsetY)
    else
        love.graphics.draw(self.sprite, self:getFace(), self.x, self.y + self.offsetY)
    end
end
