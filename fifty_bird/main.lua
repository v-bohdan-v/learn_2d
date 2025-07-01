require "constants"

local background_scroll = 0
local ground_scroll = 0

local background, ground


function love.load()
    background = love.graphics.newImage("/images/background.png")
    ground = love.graphics.newImage("/images/ground.png")

    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Fifty Bird")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {vsync = true, fullscreen = false, resizable = true})
end

function love.update(dt)
    background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    ground_scroll = (ground_scroll + GROUND_SCROLL_SPEED * dt) % WINDOW_WIDTH
end

function love.draw()
    love.graphics.draw(background, -background_scroll, 0, 0, WINDOW_WIDTH / background:getWidth(), WINDOW_HEIGHT / background:getHeight())
    love.graphics.draw(ground, -ground_scroll, WINDOW_HEIGHT - 16)
end

function love.keypressed()
    -- KEYBOARDS KEYS PROCESSING 
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end