Bird = Class{}

function Bird:init()
    self.image = BIRD
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = WINDOW_WIDTH / 2 - (self.width / 2)
    self.y = WINDOW_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY

    if love.keyboard.wasPressed("space") then
        g_sounds["jump"]:play()
        self.dy = JUMP
    end

    self.y = self.y + self.dy * dt
end

function Bird:is_collide(pipe)
    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if ((self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT) then
            return true
        end
        if (self.y + 2) <= pipe.y - GAPE then
            return true
        end
        return false
    end
end