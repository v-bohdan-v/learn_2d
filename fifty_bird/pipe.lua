Pipe = Class{}

function Pipe:init()
    self.x = WINDOW_WIDTH
    self.y = math.random(WINDOW_HEIGHT / 2, WINDOW_HEIGHT / 1.2)
    self.width = PIPE_WIDTH
    self.height = PIPE_HEIGHT
    self.scored = false
end

function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL_SPEED * dt
end

function Pipe:render()
    love.graphics.draw(
        PIPE,
        self.x,
        self.y,
        0,
        1,
        1.5
    )
    love.graphics.draw(
        PIPE, -- object
        self.x, -- x coord
        self.y - GAPE, -- y coord
        0, -- rotation
        1, -- x axis scale
        -1.5 -- y axis scale
    )
end