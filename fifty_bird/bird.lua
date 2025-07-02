Bird = Class{}

local GRAVITY = 8

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
        self.dy = -300
    end

    self.y = self.y + self.dy * dt
end