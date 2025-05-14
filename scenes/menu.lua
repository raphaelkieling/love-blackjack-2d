local love = require "love"
local Typewriter = require "utils/typewriter"

Menu = {
    banner = Typewriter:new("Welcome to Love Blackjack!", 0.01),
    start_button = Typewriter:new("Start Game", 0.1),
    quit_button = Typewriter:new("Quit Game", 0.1),
    selectorIndex = 1
}

function Menu:load()
    self.banner_font = love.graphics.newFont(32)
    self.font = love.graphics.newFont(16)
    self.banner = Typewriter:new("Welcome to Love Blackjack!", 0.01)
    self.start_button = Typewriter:new("Start Game", 0.1)
    self.quit_button = Typewriter:new("Quit Game", 0.1)
    self.selectors = {
        self.start_button,
        self.quit_button,
    }
    self.selectorIndex = 1
end

function Menu:update(dt)
    self.banner:update(dt)
    self.start_button:update(dt)
    self.quit_button:update(dt)
end

function Menu:draw()
    love.graphics.setFont(self.banner_font)

    local w = (love.graphics.getWidth() / 2) - (self.banner:getWidth(self.banner_font) / 2)
    local h = (love.graphics.getHeight() / 2) - (self.banner:getHeight(self.banner_font) / 2)

    self.banner:draw(w, h)

    love.graphics.setFont(self.font)
    self.start_button:draw(w, h + 50)
    self.quit_button:draw(w, h + 75)

    if self.selectorIndex == 1 then
        love.graphics.circle("fill", w - 10, h + 60, 5)
    end

    if self.selectorIndex == 2 then
        love.graphics.circle("fill", w - 10, h + 85, 5)
    end
end

function Menu:keypressed(key)
    if key == "return" then
        if self.selectorIndex == 1 then
            TreeScene:changeScene("game")
        end

        if self.selectorIndex == 2 then
            love.event.quit()
        end
        return
    end

    self.selectorIndex = self.selectorIndex + 1

    if self.selectorIndex > #self.selectors then
        self.selectorIndex = 1
    end
end
