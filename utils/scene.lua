local SceneManager = {}
SceneManager.__index = SceneManager

function SceneManager.new()
    local self = setmetatable({}, SceneManager)
    self.scenes = {}
    self.currentScene = nil
    return self
end

function SceneManager:addScene(name, state)
    self.scenes[name] = state
    return self
end

function SceneManager:changeScene(name, ...)
    self.currentScene = self.scenes[name]

    if self.currentScene and self.currentScene.load then
        self.currentScene:load(...)
    end

    return self
end

function SceneManager:update(dt)
    if self.currentScene and not self.currentScene.update then
        return
    end
    self.currentScene:update(dt)
end

function SceneManager:draw()
    if self.currentScene and not self.currentScene.draw then
        return
    end
    self.currentScene:draw()
end

function SceneManager:keypressed(key)
    if self.currentScene and not self.currentScene.keypressed then
        return
    end
    self.currentScene:keypressed(key)
end

function SceneManager:mousepressed(x, y, button)
    if self.currentScene and not self.currentScene.mousepressed then
        return
    end
    self.currentScene:mousepressed(x, y, button)
end

return SceneManager
