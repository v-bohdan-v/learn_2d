Class = require "class"
require "bird"
require "pipe"
require "constants"

local background_scroll = 0
local ground_scroll = 0

local pipes = {} -- an array with pipe object

local bird = Bird()


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Fifty Bird")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {vsync = true, fullscreen = false, resizable = true})
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    ground_scroll = (ground_scroll + GROUND_SCROLL_SPEED * dt) % (GROUND:getWidth() / 1.5)

    if #pipes > 0 then
        if pipes[1].x < -PIPE_WIDTH * 2 then
            table.remove(pipes, 1)
        end
    end

    if #pipes < 30 then
        local last_pipe_x = pipes[#pipes] and pipes[#pipes].x or WINDOW_WIDTH
        local gap = PIPE_WIDTH + 100
        table.insert(pipes, Pipe(last_pipe_x + gap))
    end
    print("AMOUNT OF PIPES: ", #pipes)

    for i = 1, #pipes do
        pipes[i]:update(dt)
    end

    if #pipes > 0 then
        if pipes[1].x < -PIPE_WIDTH * 2 then
            table.remove(pipes, 1)
        end
    end

    bird:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    love.graphics.draw(
        BACKGROUND, -- image
        -background_scroll, -- x position, each frame goes to minus, so it seems like the picture goes left
        0, -- y position, stable
        0, -- rotation
        3, -- scale on x axis, width * 3
        2.5 -- scale on y axis, height * 2.5
    )

    for i = 1, #pipes do
        if i > 1 and pipes[i - 1].x < WINDOW_WIDTH + PIPE_WIDTH * 1.5 then
            pipes[i]:render()
        end
    end

    love.graphics.draw(
        GROUND, -- image
        -ground_scroll, -- x position, each frame goes to minus, so it seems like the picture goes left
        WINDOW_HEIGHT - GROUND:getHeight() * 2, -- y position, stable
        0, -- rotation
        2 -- scale on x axis, width * 6
        -- 1, -- scale on y axis, hegith * 1
        -- ground:getWidth() / 2, -- ox: x-axis origin offset
        -- 0 -- oy: without offset
    )

    bird:render()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    -- KEYBOARDS KEYS PROCESSING 
    if key == "escape" then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end