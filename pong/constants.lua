-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

BASE_SPEED = 320
SPEED_MULTIPLIER = 1.1

-- paddle settings
PADDLE_X = 10
PADDLE_Y = 30
PADDLE_WIDTH = 10
PADDLE_HEIGHT = 80
PADDLE_SPEED = 400

-- ball settings
BALL_WIDTH = 12
BALL_HEIGHT = BALL_WIDTH
BALL_X = WINDOW_WIDTH / 2 - (BALL_WIDTH / 2)
BALL_Y = WINDOW_HEIGHT / 2 - (BALL_HEIGHT / 2)

-- net rect settings
RECT_WIDTH = 12
RECT_HEIGHT = RECT_WIDTH
RECT_X = WINDOW_WIDTH / 2 - (RECT_WIDTH / 2)
RECT_Y = 0
SPACER = RECT_HEIGHT / 2

-- font sizes
LARGE_FONT = 60
SCORE_FONT = 60

-- states of game
WELCOME_SCREEN = "Welcome Screen"
PLAYING = "Playing"
SERVE = "Serve"
FINISH = "FINISH"