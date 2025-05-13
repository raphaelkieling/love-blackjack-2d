local SoundManager = require "utils.sound"

function love.load()
    SoundManager.init()

    love.graphics.setDefaultFilter("nearest", "nearest")

    require("entities.card")
    require("entities.deck")
    require("entities.player")
    require("entities.game")

    Game:init()
end

function love.update(dt)
    Game:update(dt)
end

function love.draw()
    Game:draw()
end

function love.keypressed(key)
    Game:keypressed(key)
end

function love.mousepressed(x, y, button)
    Game:mousepressed(x, y, button)
end
