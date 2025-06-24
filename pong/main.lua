Class = require "class"
require "Ball"
require "constants"
require "Paddle"

function love.load()
    -- INITIALIZATIONS

    -- initialize fotns
    smallFont = love.graphics.newFont('font.ttf', SMALL_FONT)
    largeFont = love.graphics.newFont('font.ttf', LARGE_FONT)
    scoreFont = love.graphics.newFont('font.ttf', SCORE_FONT)
    love.graphics.setFont(smallFont)

    -- initialize the paddles and a ball
    playerLeft = Paddle(PADDLE_X, PADDLE_Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    playerRight = Paddle(WINDOW_WIDTH - PADDLE_WIDTH - PADDLE_X,
                         WINDOW_HEIGHT - PADDLE_HEIGHT - PADDLE_Y,
                         PADDLE_WIDTH, PADDLE_HEIGHT)
    ball = Ball(BALL_X, BALL_Y, BALL_WIDTH, BALL_HEIGHT)

    playerLeftScore = 0
    playerRightScore = 0


    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(40/250, 45/250, 52/250, 0)
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false, resizable = false, vsync = false })
end

function love.update()
    -- MAIN LOGIC
end

function love.draw()
    -- DRAWING THE OBJECTS
    playerLeft:render()
    playerRight:render()
    ball:render()
    displayScore()
end

function love.keypressed()
    -- KEYBOARDS KEYS PROCESSING 
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(playerLeftScore), WINDOW_WIDTH / 2 - SCORE_FONT * 3.5, 40)
    love.graphics.print(tostring(playerRightScore), WINDOW_WIDTH / 2 + SCORE_FONT * 2.5, 40)
end