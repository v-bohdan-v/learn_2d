StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:update(dt)
    if love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['paddle-hit']:play()
    end

    if love.keyboard.isDown('escape') then
        love.event.quit()
    end
end

function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf(
        'BREAKOUT',
        0,
        WINDOW_HEIGHT / 3,
        WINDOW_WIDTH,
        'center'
    )

    love.graphics.setFont(gFonts['medium'])
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end

    love.graphics.printf(
        'START',
        0,
        WINDOW_HEIGHT / 2 + 70,
        WINDOW_WIDTH,
        'center'
    )
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf(
        'HIGH SCORES',
        0,
        WINDOW_HEIGHT / 2 + 80,
        WINDOW_WIDTH,
        'center'
    )
    love.graphics.setColor(1, 1, 1, 1)
end
