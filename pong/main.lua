Class = require "class"
local controls = require "controls"
require "ball"
require "constants"
require "paddle"
require "net"

-- variables
local small_font, large_font, score_font
local player_left, player_right, ball, net
local player_left_score, player_right_score, game_state, serve_count, serving_player

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

    game_state = WELCOME_SCREEN
    serving_player = 0
    serve_count = 0

    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(40/250, 45/250, 52/250, 0)
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false, resizable = false, vsync = false })
end

function love.update(dt)
    -- MAIN LOGIC
    -- Game start and throw the ball
    if love.keyboard.isDown("return") and (game_state == WELCOME_SCREEN or game_state == FINISH) then
        game_state = PLAYING
        serving_player = math.random(1, 2)
        serve_count = serve_count + 1
        ball.dy = math.random(-220, 220)
        if serving_player == 1 then
           ball.dx = -math.random(300, 400)
        else
           ball.dx = math.random(300, 400)
        end
    end

    if game_state == SERVE then
        game_state = PLAYING
        ball:reset()
        ball.dy = math.random(-220, 220)
        print(serve_count)
        if serve_count > 5 and serving_player == 1 then
            serving_player = 2
        elseif serve_count > 5 and serve_count == 2 then
            serving_player = 1
        end

        if serving_player == 1 then
            ball.dx = -math.random(300, 400)
        elseif serving_player == 2 then
            ball.dx = math.random(300, 400)
        end
    end

    if serve_count == 11 then
       game_state = FINISH
    end

    -- Left player moving
    controls.move_paddle(player_left, "w", "s")
    -- Right player moving
    controls.move_paddle(player_right, "up", 'down')

    if ball:is_collides_paddle(player_left) then
            ball.x = player_left.x + player_left.width + 5
            ball.dx = -ball.dx * 1.05
            set_ball_direction_when_collides_paddle(player_left)
    end

    if ball:is_collides_paddle(player_right) then
        ball.x = player_right.x - (ball.width + 5)
        ball.dx = -ball.dx * 1.05
        set_ball_direction_when_collides_paddle(player_right)
    end

    -- If ball collides the ceil, then it should go to the floor
    if ball:is_collides_ceil() then
        ball.y = 0
        ball.dy = -ball.dy
    end

    -- If ball collides the floor, then it should go to the ceil
    if ball:is_collides_floor() then
        ball.y = WINDOW_HEIGHT - ball.height
        ball.dy = -ball.dy
    end

    if ball:is_collides_left_side() then
        player_right_score = count_score(player_right_score)
        serve_count = serve_count + 1
    end

    if ball:is_collides_right_side() then
        player_left_score = count_score(player_left_score)
        serve_count = serve_count + 1
    end

    -- update objects
    player_left:update(dt)
    player_right:update(dt)
    ball:update(dt)
end

function love.draw()
    -- DRAWING THE OBJECTS
    -- render welcome screen
    if game_state == WELCOME_SCREEN then
       display_welcome_screen()
    elseif game_state == FINISH then
        local player = ""
        if player_left_score == player_right_score then
            player = "Draw!"
        elseif player_left_score > player_right_score then
            player = "1"
        else
            player = "2"
        end
        display_finish_screen(player)
        player_left_score = 0
        player_right_score = 0
        serve_count = 0
        serving_player = 0
    else
        -- render the paddles, ball and the net
        player_left:render()
        player_right:render()
        ball:render()
        local segmentCount = WINDOW_HEIGHT / (RECT_HEIGHT + SPACER)
        for i = 0, segmentCount do
            local y = i * (RECT_HEIGHT + SPACER)
            net:render(y)
        end

        -- render the scores
        display_score()
    end
end

function love.keypressed()
    -- KEYBOARDS KEYS PROCESSING 
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

--- Set ball direction when it collides paddle. If it collides top side of paddle, then it should go to the ceil,
--- otherwise to the floor
---@param player table paddle
function set_ball_direction_when_collides_paddle(player)
    if ball.y < player.y + player.height / 2 then
            ball.dy = -math.random(100, 200) * (player.y + (player.height / 2)) / ball.y
        else
            ball.dy = math.random(100, 200) * (player.y + player.height) / ball.y
        end
end

--- Count score for players
--- @param player_score string current score of left or right player
--- @return integer increment value of current player score
function count_score(player_score)
    ball:reset()
    game_state = SERVE
    player_score = player_score + 1
    return player_score
end

function display_welcome_screen()
    local text = "Press 'Enter' to start"
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    local textHeight = font:getHeight()
    love.graphics.setFont(large_font)
    love.graphics.print(tostring(text), (WINDOW_WIDTH - textWidth) / 2,
                         (WINDOW_HEIGHT - textHeight) / 2)
end

function display_finish_screen(player)
    local text = "Player " ..  player .. " wins!\nPlease press 'Enter' to play again"
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    local textHeight = font:getHeight()
    love.graphics.setFont(large_font)
    love.graphics.print(tostring(text), (WINDOW_WIDTH - textWidth) / 2,
                         (WINDOW_HEIGHT - textHeight) / 2)
end

function display_score()
    love.graphics.setFont(score_font)
    love.graphics.print(tostring(player_left_score), WINDOW_WIDTH / 2 - SCORE_FONT * 3.5, 40)
    love.graphics.print(tostring(player_right_score), WINDOW_WIDTH / 2 + SCORE_FONT * 2.5, 40)
end