Pipe = Class{}

function Pipe:init(x)
    self.x = x or WINDOW_WIDTH
    self.y = math.random(WINDOW_HEIGHT / 2, WINDOW_HEIGHT - 2)
    self.width = PIPE_WIDTH
    self.height = PIPE_HEIGHT
    self.orientation = 0
end

function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL_SPEED * dt
end

function Pipe:render()
    love.graphics.draw(PIPE, self.x, self.y)
end