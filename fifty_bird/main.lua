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
    ground_scroll = (ground_scroll + GROUND_SCROLL_SPEED * dt) % (ground:getWidth() / 1.5)
end

function love.draw()
    love.graphics.draw(
        background, -- image
        -background_scroll, -- x position, each frame goes to minus, so it seems like the picture goes left
        0, -- y position, stable
        0, -- rotation
        3, -- scale on x axis, width * 3
        2.5 -- scale on y axis, height * 2.5
    )
    love.graphics.draw(
        ground, -- image
        -ground_scroll, -- x position, each frame goes to minus, so it seems like the picture goes left
        WINDOW_HEIGHT - ground:getHeight() * 2, -- y position, stable
        0, -- rotation
        2 -- scale on x axis, width * 6
        -- 1, -- scale on y axis, hegith * 1
        -- ground:getWidth() / 2, -- ox: x-axis origin offset
        -- 0 -- oy: without offset
    )
end

function love.keypressed()
    -- KEYBOARDS KEYS PROCESSING 
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end