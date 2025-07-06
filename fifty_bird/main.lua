Class = require "class"
-- constants
require "constants"

-- objects
require "image"
require "bird"
require "pipe"

-- game state and state machines
require "state_machine"
require "states.base_state"
require "states.play_state"
require "states.title_screen_state"
require "states.score_state"

local background_scroll = 0
local ground_scroll = 0

local background = Image(BACKGROUND, 0, 0, 3, 2.5, 1)
local ground = Image(GROUND, 0, WINDOW_HEIGHT - GROUND:getHeight() * 2, 6, 2, 2)


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Fifty Bird")

    -- set fonts
    small_font = love.graphics.newFont("font.ttf", SMALL_FONT)
    medium_font = love.graphics.newFont("font.ttf", MEDIUM_FONT)
    large_font = love.graphics.newFont("font.ttf", LARGE_FONT)
    love.graphics.setFont(medium_font)
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {vsync = true, fullscreen = false, resizable = true})

    -- set sounds
    g_sounds = {
        ["jump"] = love.audio.newSource(JUMP_SOUND, "static"),
        ["explosion"] = love.audio.newSource(BOOM_SOUND, "static"),
        ["score"] = love.audio.newSource(SCORE_SOUND, "static"),
        ["music"] = love.audio.newSource(PLAY_SOUND, "static")
    }

    g_sounds["music"]:setLooping(true)
    g_sounds["music"]:setVolume(0.1)
    g_sounds["music"]:play()

    -- initialize state machine
    g_state_machine = StateMachine {
        ["title"] = function () return TitleScreenState() end,
        ["play"] = function() return PlayState() end,
        ["score"] = function() return ScoreState() end
    }
    g_state_machine:change("title")

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    background_scroll = background_scroll + BACKGROUND_SCROLL_SPEED * dt
    ground_scroll = ground_scroll + GROUND_SCROLL_SPEED * dt

    g_state_machine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    background:render(background_scroll)
    g_state_machine:render()
    ground:render(ground_scroll)
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