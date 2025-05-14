local love = require "love"
local Typewriter = require "utils/typewriter"

Lose = {}

function Lose:load()
    self.banner_font = love.graphics.newFont(32)
    self.font = love.graphics.newFont(16)
    self.restart_game = Typewriter:new("Back to menu", 0.1)
    self.quit_button = Typewriter:new("Quit Game", 0.1)
    self.selectors = {
        self.restart_game,
        self.quit_button,
    }
    self.banner = Typewriter:new("You lose :(", 0.01)
    self.selectorIndex = 1
end

function Lose:update(dt)
    self.banner:update(dt)
    self.restart_game:update(dt)
    self.quit_button:update(dt)
end

function Lose:draw()
    love.graphics.setFont(self.banner_font)

    local w = (love.graphics.getWidth() / 2) - (self.banner:getWidth(self.banner_font) / 2)
    local h = (love.graphics.getHeight() / 2) - (self.banner:getHeight(self.banner_font) / 2)

    self.banner:draw(w, h)

    love.graphics.setFont(self.font)
    self.restart_game:draw(w, h + 50)
    self.quit_button:draw(w, h + 75)

    if self.selectorIndex == 1 then
        love.graphics.circle("fill", w - 10, h + 60, 5)
    end

    if self.selectorIndex == 2 then
        love.graphics.circle("fill", w - 10, h + 85, 5)
    end
end

function Lose:keypressed(key)
    if key == "return" then
        if self.selectorIndex == 1 then
            TreeScene:changeScene("menu")
            return
        end

        if self.selectorIndex == 2 then
            love.event.quit()
            return
        end
    end

    self.selectorIndex = self.selectorIndex + 1

    if self.selectorIndex > #self.selectors then
        self.selectorIndex = 1
    end
end
