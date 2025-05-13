local love = require "love"
local SoundManager = require "utils.sound"
local SceneManager = require "utils.scene"

require("entities.card")
require("entities.deck")
require("entities.player")
require("scenes.game")
require("scenes.menu")
require("scenes.win")

local crtShader
local canvas

function love.load()
    SoundManager.init()
    TreeScene = SceneManager
        :new()
        :addScene("menu", Menu)
        :addScene("game", Game)
        :addScene("win", Win)
        :addScene("game_over", {})
        :changeScene("menu")

    -- Graphic stuff
    love.graphics.setDefaultFilter("nearest", "nearest")
    crtShader = love.graphics.newShader("assets/crt.glsl")
    canvas = love.graphics.newCanvas()

    crtShader:send("iChannel0", canvas)
end

function love.update(dt)
    TreeScene:update(dt)
end

function love.draw()
    -- draw the canvas first
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    TreeScene:draw()
    love.graphics.setCanvas()

    -- apply shader
    love.graphics.setShader(crtShader)
    love.graphics.draw(canvas, 0, 0)
    love.graphics.setShader()
end

function love.keypressed(key)
    TreeScene:keypressed(key)
end

function love.mousepressed(x, y, button)
    TreeScene:mousepressed(x, y, button)
end
