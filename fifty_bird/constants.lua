-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- scroll speed
BACKGROUND_SCROLL_SPEED = 30
GROUND_SCROLL_SPEED = 120
PIPE_SCROLL_SPEED = -120
GRAVITY = 8
JUMP = -300


-- images
BACKGROUND = love.graphics.newImage("/images/background.png")
GROUND = love.graphics.newImage("/images/ground.png")
BIRD = love.graphics.newImage("/images/bird.png")
PIPE = love.graphics.newImage("/images/pipe.png")

-- Pipe
GAPE = 100
PIPE_HEIGHT = 288
PIPE_WIDTH = 70

-- fonts
SMALL_FONT = 8
MEDIUM_FONT = 14
LARGE_FONT = 60

-- sounds path
PLAY_SOUND = "/sounds/play_sound.mp3"
BOOM_SOUND = "/sounds/boom.wav"
JUMP_SOUND = "/sounds/jump.wav"
SCORE_SOUND = "/sounds/score.wav"