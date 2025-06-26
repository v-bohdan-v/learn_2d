local controls = {}

function controls.move_paddle(player, key_up, key_down)
    if love.keyboard.isDown(key_up) then
        player.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown(key_down) then
        player.dy = PADDLE_SPEED
    else
        player.dy = 0
    end
end

return controls

