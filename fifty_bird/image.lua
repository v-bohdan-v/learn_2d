Image = Class{}

function Image:init(image, x, y, scale_x, scale_y, image_width_scale)
    self.x = x
    self.y = y
    self.scrol_speed = 0
    self.scale_x = scale_x or 1
    self.scale_y = scale_y or 1
    self.image = image
    self.width = self.image:getWidth() / image_width_scale
end

function Image:render(scroll_speed)
    local scale_width = self.width * self.scale_x
    local x1 = -scroll_speed % scale_width
    local x2 = x1 - scale_width
    love.graphics.draw(
        self.image, -- object to draw
        x1, -- x position, should be minus to create a move effect to the left
        self.y, -- y positions, stable
        0, -- rotation
        self.scale_x, -- x scale - scale a picture width-wise
        self.scale_y -- y scale - scale a picture height-wise
    )
    love.graphics.draw(
        self.image, -- object to draw
        x2, -- x position, should be minus to create a move effect to the left
        self.y, -- y positions, stable
        0, -- rotation
        self.scale_x, -- x scale - scale a picture width-wise
        self.scale_y -- y scale - scale a picture height-wise
    )
end