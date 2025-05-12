Deck = {
    cards = {}
}

function Deck:new()
    local suits = { "hearts", "diamonds", "clubs", "spades" }
    local values = { "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K" }

    local obj = { cards = {} }
    for _, suit in ipairs(suits) do
        for _, value in ipairs(values) do
            local newCard = Card:new(suit, value)
            newCard:load()
            table.insert(obj.cards, newCard)
        end
    end
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Deck:shuffle()
    for i = #self.cards, 2, -1 do
        local j = math.random(i)
        self.cards[i], self.cards[j] = self.cards[j], self.cards[i]
    end
end

function Deck:drawCard()
    return table.remove(self.cards, 1)
end
