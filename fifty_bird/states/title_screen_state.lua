TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed("return") then
        g_state_machine:change("play")
    end
end

function TitleScreenState:render()
    love.graphics.setFont(large_font)
    love.graphics.printf("Fifty Bird", 0, 64, WINDOW_WIDTH, "center")
    love.graphics.printf("Press enter to start", 0, 200, WINDOW_WIDTH, "center")
end