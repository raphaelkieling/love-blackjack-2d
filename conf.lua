local love = require("love")
function love.conf(t)
    t.window.width = 800
    t.window.height = 600
    t.window.title = "Blackjack"
    t.window.resizable = false
    t.window.fullscreen = false
    t.window.vsync = true
end
