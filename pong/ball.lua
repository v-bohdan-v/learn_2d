Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
    self.dx = 0
end

function Ball:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:reset()
    self.x = BALL_X
    self.y = BALL_Y
    self.dx = 0
    self.dy = 0
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:is_collides_paddle(paddle)
    if self.x >= paddle.x + paddle.width or paddle.x >= self.x + self.width then
        return false
    end

    if self.y >= paddle.y + paddle.height or paddle.y >= self.y + self.height then
        return false
    end

    return true
end

function Ball:collides_border()
    if self.y <= 0 then
        self.y = 0
        self.dy = self.dy
    end

    if self.y >= WINDOW_HEIGHT then
        self.y = WINDOW_HEIGHT - BALL_HEIGHT
        self.dy = -self.dy
    end
end