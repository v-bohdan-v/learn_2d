NetRect = Class{}

function NetRect:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function NetRect:render(y)
    love.graphics.rectangle("fill", self.x, y, self.width, self.height)
end