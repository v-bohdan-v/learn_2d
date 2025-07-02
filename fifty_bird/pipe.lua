Pipe = Class{}

function Pipe:init()
    self.x = WINDOW_WIDTH
    self.y = math.random(WINDOW_WIDTH / 2, WINDOW_HEIGHT - 10)
    self.width = PIPE:getWidth()
end

function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL_SPEED * dt
end

function Pipe:render()
    love.graphics.draw(PIPE, self.x, self.y)
end