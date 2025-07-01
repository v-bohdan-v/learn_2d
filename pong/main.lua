Class = require "class"
local controls = require "controls"
local game = require "logic"
require "ball"
require "paddle"
require "net"
require "constants"

-- variables
local large_font, score_font, sounds
local player_left, player_right, ball, net
local player_left_score, player_right_score, game_state, serve_count, serving_player, winner, curr_speed

function love.load()
    -- INITIALIZATIONS

    love. window.setTitle("Pong")

    math.randomseed(os.time())

    -- initialize fotns
    large_font = love.graphics.newFont('font.ttf', LARGE_FONT)
    score_font = love.graphics.newFont('font.ttf', SCORE_FONT)
    love.graphics.setFont(score_font)

    sounds = {
        ["paddle"] = love.audio.newSource("sounds/paddle.wav", "static"),
        ["border"] = love.audio.newSource("sounds/border.wav", "static"),
        ["lose"] = love.audio.newSource("sounds/lose.wav", "static"),
    }

    -- initialize the paddles and a ball
    player_left= Paddle(PADDLE_X, PADDLE_Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    player_right = Paddle(WINDOW_WIDTH - PADDLE_WIDTH - PADDLE_X,
                         WINDOW_HEIGHT - PADDLE_HEIGHT - PADDLE_Y,
                         PADDLE_WIDTH, PADDLE_HEIGHT)
    ball = Ball(BALL_X, BALL_Y, BALL_WIDTH, BALL_HEIGHT)
    net = NetRect(RECT_X, RECT_Y, RECT_WIDTH, RECT_HEIGHT)

    player_left_score, player_right_score, serving_player, serve_count = game.reset_values()

    game_state = WELCOME_SCREEN

    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(40/250, 45/250, 52/250, 0)
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false, resizable = false, vsync = false })
end

function love.update(dt)
    -- MAIN LOGIC
    -- Game start and throw the ball
    if serve_count == 11 then
        game_state = FINISH
        winner = game.get_winner(player_left_score, player_right_score)
    end

    if love.keyboard.isDown("return") and (game_state == WELCOME_SCREEN or game_state == FINISH) then
        game_state = PLAYING
        serving_player = game.set_first_serve()
        serve_count = serve_count + 1
        game.do_first_serve(ball, serving_player)
        if serving_player == 1 then
            curr_speed = -BASE_SPEED
        else
            curr_speed = BASE_SPEED
        end
    end

    if game_state == SERVE then
        game_state = PLAYING
        ball:reset()
        game.process_serving(ball, curr_speed, serve_count)
    end

    -- Left player moving
    controls.move_paddle(player_left, "w", "s")
    -- Right player moving
    controls.move_paddle(player_right, "up", 'down')

    if ball:is_collides_paddle(player_left) then
        ball.x = player_left.x + player_left.width + ball.width
        ball.dx = -ball.dx * SPEED_MULTIPLIER
        game.set_ball_direction_when_collides_paddle(ball, player_left)
        sounds["paddle"]:play()
    end

    if ball:is_collides_paddle(player_right) then
        ball.x = player_right.x - ball.width
        ball.dx = -ball.dx * SPEED_MULTIPLIER
        game.set_ball_direction_when_collides_paddle(ball, player_right)
        sounds["paddle"]:play()
    end

    -- If ball collides the ceil, then it should go to the floor
    if ball:is_collides_ceil() then
        ball.y = 0
        ball.dy = -ball.dy
        sounds["border"]:play()
    end

    -- If ball collides the floor, then it should go to the ceil
    if ball:is_collides_floor() then
        ball.y = WINDOW_HEIGHT - ball.height
        ball.dy = -ball.dy
        sounds["border"]:play()
    end

    if ball:is_collides_left_side() then
        player_right_score= game.count_score(ball, player_right_score)
        game_state = SERVE
        serve_count = serve_count + 1
        sounds["lose"]:play()
    end

    if ball:is_collides_right_side() then
        player_left_score = game.count_score(ball, player_left_score)
        game_state = SERVE
        serve_count = serve_count + 1
        sounds["lose"]:play()
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
       game.display_welcome_screen(large_font)
    elseif game_state == FINISH then
        game.display_finish_screen(winner, large_font)
        player_left_score, player_right_score, serve_count, serving_player = game.reset_values()
    else
        -- render the paddles, ball and the net
        player_left:render()
        player_right:render()
        ball:render()
        net:render()

        -- render the scores
        game.display_score(player_left_score, player_right_score, score_font)
    end
end

function love.keypressed()
    -- KEYBOARDS KEYS PROCESSING 
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end
