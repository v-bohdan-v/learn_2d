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