Class = require "class"
require "bird"
require "pipe"
require "constants"

local pipes = {}

local background_scroll = 0
local ground_scroll = 0
local spawn_timer = 0

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

    spawn_timer = spawn_timer + dt
    if spawn_timer > 1 then
        table.insert(pipes, Pipe())
        spawn_timer = 0
    end

    bird:update(dt)

    for k, p in pairs(pipes) do
        p:update(dt)

        if p.x < -p.width then
            table.remove(p, k)
        end
    end

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

    for k, p in pairs(pipes) do
        p:render()
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