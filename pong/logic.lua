local game = {}

function game.get_winner(player_left_score, player_right_score)
    if player_left_score == player_right_score then
        return"draft"
    elseif player_left_score > player_right_score then
        return "1"
    else
        return "2"
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
    return player_score, SERVE
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