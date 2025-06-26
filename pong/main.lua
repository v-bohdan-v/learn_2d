Class = require "class"
local controls = require "controls"
require "ball"
require "constants"
require "paddle"
require "net"

-- variables
local small_font, large_font, score_font
local player_left, player_right, ball, net
local player_left_score, player_right_score, game_state, serving_player

function love.load()
    -- INITIALIZATIONS
    math.randomseed(os.time())

    -- initialize fotns
    small_font= love.graphics.newFont('font.ttf', SMALL_FONT)
    large_font = love.graphics.newFont('font.ttf', LARGE_FONT)
    score_font = love.graphics.newFont('font.ttf', SCORE_FONT)
    love.graphics.setFont(score_font)

    -- initialize the paddles and a ball
    player_left= Paddle(PADDLE_X, PADDLE_Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    player_right = Paddle(WINDOW_WIDTH - PADDLE_WIDTH - PADDLE_X,
                         WINDOW_HEIGHT - PADDLE_HEIGHT - PADDLE_Y,
                         PADDLE_WIDTH, PADDLE_HEIGHT)
    ball = Ball(BALL_X, BALL_Y, BALL_WIDTH, BALL_HEIGHT)
    net = NetRect(RECT_X, RECT_Y, RECT_WIDTH, RECT_HEIGHT)

    player_left_score= 0
    player_right_score = 0

    game_state = "Start"
    serving_player = 1


    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(40/250, 45/250, 52/250, 0)
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false, resizable = false, vsync = false })
end

function love.update(dt)
    -- MAIN LOGIC
    -- Left player moving
    controls.move_paddle(player_left, "w", "s")

    -- Right player moving
    controls.move_paddle(player_right, "up", 'down')


    -- Game start and throw the ball
    if love.keyboard.isDown("return") and game_state == "Start" then
        game_state = "Play"
        ball.dy = math.random(-220, 220)
        serving_player = math.random(1, 2)
        if serving_player == 2 then
            ball.dx = math.random(300, 400)
        else
            ball.dx = -math.random(300, 400)
        end
    end

    if love.keyboard.isDown("space") then
        ball:reset()
        game_state = "Start"
    end

    -- update objects
    player_left:update(dt)
    player_right:update(dt)
    ball:update(dt)
end

function love.draw()
    -- DRAWING THE OBJECTS
    player_left:render()
    player_right:render()
    ball:render()
    local segmentCount = WINDOW_HEIGHT / (RECT_HEIGHT + SPACER)
    for i = 0, segmentCount do
        local y = i * (RECT_HEIGHT + SPACER)
        net:render(y)
    end
    displayScore()
end

function love.keypressed()
    -- KEYBOARDS KEYS PROCESSING 
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function displayScore()
    love.graphics.setFont(score_font)
    love.graphics.print(tostring(player_left_score), WINDOW_WIDTH / 2 - SCORE_FONT * 3.5, 40)
    love.graphics.print(tostring(player_right_score), WINDOW_WIDTH / 2 + SCORE_FONT * 2.5, 40)
end