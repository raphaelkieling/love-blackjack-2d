Player = {
    hand = {},
    money = 1000,
    bet = 0
}

function Player:load()
end

function Player:new()
    local obj = { hand = {}, money = 1000, bet = 0 }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Player:addCard(card)
    table.insert(self.hand, card)
end

function Player:isBusted()
    if self:getHandValue() > 21 then
        return true
    end

    return false
end

function Player:getHandValue()
    local value = 0
    local aces = 0

    for _, card in ipairs(self.hand) do
        if card.faceUp then
            if card.value == "A" then
                value = value + 11
                aces = aces + 1
            elseif card.value == "J" or card.value == "Q" or card.value == "K" then
                value = value + 10
            else
                value = value + tonumber(card.value)
            end
        end
    end

    -- Ajusta Ás se estourar
    while value > 21 and aces > 0 do
        value = value - 10
        aces = aces - 1
    end

    return value
end
