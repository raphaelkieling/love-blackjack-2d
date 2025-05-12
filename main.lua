function love.load()
    -- Carrega módulos
    require("entities.card")
    require("entities.deck")
    require("entities.player")
    require("entities.game")

    -- Inicializa o jogo
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
