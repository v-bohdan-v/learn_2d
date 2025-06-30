NetRect = Class{}

function NetRect:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function NetRect:render()
    local segmentCount = WINDOW_HEIGHT / (RECT_HEIGHT + SPACER)
        for i = 0, segmentCount do
            local y = i * (RECT_HEIGHT + SPACER)
            love.graphics.rectangle("fill", self.x, y, self.width, self.height)
        end
end