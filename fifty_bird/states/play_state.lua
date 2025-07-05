PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.bird = Bird()
    self.pipes = {}
    self.timer = 0
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

    for i = 1, #self.pipes do
        self.pipes[i]:update(dt)

        if self.bird:is_collide(self.pipes[i]) then
            g_state_machine:change("title")
        end
    end

    if #self.pipes > 0 then
        if self.pipes[1].x + PIPE_WIDTH < 0 then
            table.remove(self.pipes, 1)
        end
    end

    self.bird:update(dt)
end

function PlayState:render()
    for i = 1, #self.pipes do
        self.pipes[i]:render()
    end
    self.bird:render()
end