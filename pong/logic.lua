local game = {}

function game.reset_values()
    return 0, 0, 0, 0, 0
end

---Get a random DY to set Y direction for ball
---@return integer random number from -350 to 350
function game.get_random_dy()
    return math.random(-350, 350)
end

---Get winner in the game
---@param player_left_score string left player score
---@param player_right_score string right player score
---@return string if scores are equal return Draft, otherwise first or second player
function game.get_winner(player_left_score, player_right_score)
    if player_left_score == player_right_score then
        return"draft"
    elseif player_left_score > player_right_score then
        return "1"
    else
        return "2"
    end
end

---Set first serve, if 1, ball will be throwed to the left side, otherwise to the right side
---@return integer number of the player
function game.set_first_serve()
    return math.random(1, 2)
end

---Throw ball to the left or right side, depends on serving player
---@param ball table ball objects to set dy and dx
---@param serving_player integer first or second player
function game.do_first_serve(ball, serving_player)
    local speed = game.get_random_dy()
    if serving_player == 1 then
        ball.dy = speed
        ball.dx = -BASE_SPEED
    else
        ball.dy = speed
        ball.dx = BASE_SPEED
    end
end

---Process serving wher one of the player are get the goal. First 5 serve depends on the set_first_serve,
--- and the second ones to the another side
---@param ball table ball objects to reset dy and dx
---@param curr_speed any
---@param serve_count any
function game.process_serving(ball, curr_speed, serve_count)
    local speed = game.get_random_dy()
    if serve_count > 5 and curr_speed > 0 then
        ball.dy = speed
        ball.dx = -BASE_SPEED
    elseif serve_count > 5  and serve_count < 11 then
        ball.dy = speed
        ball.dx = BASE_SPEED
    else
        ball.dx = curr_speed
        ball.dy = speed
    end
end

--- Set ball direction when it collides paddle. If it collides top side of paddle, then it should go to the ceil,
--- otherwise to the floor
---@param player table paddle
function game.set_ball_direction_when_collides_paddle(ball, player)
    if ball.y < player.y + player.height / 2 then
            ball.dy = -math.random(100, 200) * (player.y + (player.height / 2)) / ball.y
        else
            ball.dy = math.random(100, 200) * (player.y + player.height) / ball.y
        end
end

--- Count score for players
--- @param player_score string current score of left or right player
--- @return integer increment value of current player score
--- @return string game state
function game.count_score(ball, player_score)
    ball:reset()
    player_score = player_score + 1
    return player_score
end

function game.display_welcome_screen(font)
    local text = "Press 'Enter' to start"
    local text_width, text_height = game.get_text_size(text)
    game.display_text(text, font, text_width, text_height)
end

function game.display_finish_screen(winner, font)
    local text
    if winner == "draft" then
        text = "It is draft!"
    else
        text = "Player " ..  winner .. " wins!"
    end
    text = text .. "\nPlease press 'Enter' to play again!"
    local text_width, text_height = game.get_text_size(text)
    game.display_text(text, font, text_width, text_height)
end

function game.get_text_size(text)
    local curr_font = love.graphics.getFont()
    local text_width = curr_font:getWidth(text)
    local text_height = curr_font:getHeight()
    return text_width, text_height
end

function game.display_text(text, font, text_width, text_height)
    love.graphics.setFont(font)
    love.graphics.print(tostring(text), (WINDOW_WIDTH - text_width) / 2,
                         (WINDOW_HEIGHT - text_height) / 2)
end

function game.display_score(player_left_score, player_right_score, font)
    love.graphics.setFont(font)
    love.graphics.print(tostring(player_left_score), WINDOW_WIDTH / 2 - SCORE_FONT * 3.5, 40)
    love.graphics.print(tostring(player_right_score), WINDOW_WIDTH / 2 + SCORE_FONT * 2.5, 40)
end

return game