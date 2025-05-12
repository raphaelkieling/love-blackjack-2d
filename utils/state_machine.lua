local StateMachine = {}
StateMachine.__index = StateMachine

-- Construtor: cria uma nova máquina de estados
function StateMachine.new()
    local self = setmetatable({}, StateMachine)
    self.currentState = nil
    self.states = {} -- Tabela de estados registrados
    return self
end

-- Adiciona um estado à máquina
function StateMachine:addState(name, state)
    self.states[name] = state
    return self
end

-- Muda para um novo estado (opcional: passa argumentos para enter())
function StateMachine:changeState(name, ...)
    -- Executa exit() do estado atual (se existir)
    if self.currentState and self.currentState.exit then
        self.currentState:exit()
    end

    -- Define o novo estado
    self.currentState = self.states[name]

    -- Executa enter() do novo estado (se existir)
    if self.currentState and self.currentState.enter then
        self.currentState:enter(...)
    end
end

-- Delega update(), draw() e input para o estado atual
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

-- Retorna a classe para ser usada com require()
return StateMachine
