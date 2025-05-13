local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine.new()
    local self = setmetatable({}, StateMachine)
    self.currentState = nil
    self.states = {}
    return self
end

function StateMachine:addState(name, state)
    self.states[name] = state
    return self
end

function StateMachine:changeState(name, ...)
    if self.currentState and self.currentState.exit then
        self.currentState:exit()
    end

    self.currentState = self.states[name]

    if self.currentState and self.currentState.enter then
        self.currentState:enter(...)
    end
end

function StateMachine:update(dt)
    if self.currentState and self.currentState.update then
        self.currentState:update(dt)
    end
end

function StateMachine:draw()
    if self.currentState and self.currentState.draw then
        self.currentState:draw()
    end
end

function StateMachine:mousepressed(x, y, button)
    if self.currentState and self.currentState.mousepressed then
        self.currentState:mousepressed(x, y, button)
    end
end

function StateMachine:keypressed(key)
    if self.currentState and self.currentState.keypressed then
        self.currentState:keypressed(key)
    end
end

return StateMachine
