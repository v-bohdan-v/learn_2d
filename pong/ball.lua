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

function Ball:is_collides_ceil()
    if self.y >= 0 then
        return false
    end
    return true
end

function Ball:is_collides_floor()
    if self.y + self.width <= WINDOW_HEIGHT then
        return false
    end
    return true
end

function Ball:is_collides_left_side()
    if self.x >= 0 then
        return false
    end
    return true
end

function Ball:is_collides_right_side()
    if self.x + self.width <= WINDOW_WIDTH then
        return false
    end
    return true
end