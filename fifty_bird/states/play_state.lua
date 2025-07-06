PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.bird = Bird()
    self.pipes = {}
    self.timer = 0
    self.score = 0
end

function PlayState:update(dt)
    if #self.pipes > 0 then
        if self.pipes[1].x < -PIPE_WIDTH * 2 then
            table.remove(self.pipes, 1)
        end
    end

    self.timer = self.timer + dt
    if self.timer > 3 then
        table.insert(self.pipes, Pipe())
        self.timer = 0
    end

    self.bird:update(dt)

    for i = 1, #self.pipes do
        self.pipes[i]:update(dt)

        if not self.pipes[i].scored then
            if self.pipes[i].x + PIPE_WIDTH < self.bird.x then
                g_sounds["score"]:play()
                self.score = self.score + 1
                self.pipes[i].scored = true
            end
        end

        if self.bird:is_collide(self.pipes[i]) then
            g_sounds["explosion"]:play()
            g_state_machine:change("score", { score = self.score })
        end
    end

    if self.bird.y > WINDOW_HEIGHT - GROUND:getHeight() * 2 then
        g_sounds["explosion"]:play()
        g_state_machine:change("score", { score = self.score })
    end

    if #self.pipes > 0 then
        if self.pipes[1].x + PIPE_WIDTH < 0 then
            table.remove(self.pipes, 1)
        end
    end

end

function PlayState:render()
    for i = 1, #self.pipes do
        self.pipes[i]:render()
    end
    self.bird:render()
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
end
