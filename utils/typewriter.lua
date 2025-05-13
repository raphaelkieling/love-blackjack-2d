local Typewriter = {}
Typewriter.__index = Typewriter

function Typewriter:new(text, speed)
    local obj = setmetatable({}, self)
    obj.fullText = text or ""
    obj.speed = speed or 0.05
    obj.timer = 0
    obj.index = 0
    obj.finished = false
    return obj
end

function Typewriter:update(dt)
    if self.finished then return end

    self.timer = self.timer + dt
    if self.timer >= self.speed then
        self.index = self.index + 1
        self.timer = 0

        if self.index >= #self.fullText then
            self.index = #self.fullText
            self.finished = true
        end
    end
end

function Typewriter:draw(x, y)
    love.graphics.print(self:getCurrentText(), x, y)
end

function Typewriter:getWidth(font)
    return font:getWidth(self:getCurrentText())
end

function Typewriter:getHeight(font)
    return font:getHeight(self:getCurrentText())
end

function Typewriter:getCurrentText()
    return string.sub(self.fullText, 1, self.index)
end

function Typewriter:isFinished()
    return self.finished
end

function Typewriter:skip()
    self.index = #self.fullText
    self.finished = true
end

return Typewriter
