ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
   self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed("return") then
        g_state_machine:change("play")
    end
end

function ScoreState:render()
    love.graphics.setFont(large_font)
    love.graphics.printf("You lost!", 0, 64, WINDOW_WIDTH, "center")
    love.graphics.printf("Score: " .. tostring(self.score), 0, 150, WINDOW_WIDTH, "center")
    love.graphics.printf("Press enter to play again!", 0, 200, WINDOW_WIDTH, "center")
end