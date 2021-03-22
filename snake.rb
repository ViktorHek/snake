require 'ruby2d'

set background: 'maroon'
set fps_cap: 20

GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE

class Snake
  attr_writer :direction

  def initialize
    @positions = [[2, 0],[2, 1], [2, 2], [2, 3]] 
    @direction = 'down'
  end

  def draw
    @positions.each do |position|
      Square.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: GRID_SIZE - 1, color: 'orange')
    end
  end

  def move
    @positions.shift
    case @direction
    when 'down'
      @positions.push(new_coords(head[0], head[1] + 1))
    when 'up'
      @positions.push(new_coords(head[0], head[1] - 1))
    when 'left'
      @positions.push(new_coords(head[0] - 1, head[1]))
    when 'right'
      @positions.push(new_coords(head[0] + 1, head[1]))
    end
  end

  def can_change_direction?(new_direction)
    case @direction
    when 'up' then new_direction != 'down'
    when 'down' then new_direction != 'up'
    when 'left' then new_direction != 'right'
    when 'right' then new_direction != 'left'
    end
  end

  def x
    head[0]
  end

  def y
    head[1]
  end
  
  private

  def new_coords(x, y)
    [x % GRID_WIDTH, y % GRID_HEIGHT]
  end

  def head
    @positions.last
  end
end

class Game
  def initialize
    @score = 0
    @apple_x = rand(GRID_WIDTH)
    @apple_y = rand(GRID_HEIGHT)
  end

  def draw
    Square.new(x: @apple_x * GRID_SIZE, y: @apple_y * GRID_SIZE, size: GRID_SIZE, color: 'green')
    Text.new("Score #{@score}", color: "white", x: 10, y: 10, size: 25 )
  end

  def snake_eat_apple?(x, y)
    @apple_x == x && @apple_y == y
  end

  def points
    @score += 1
    @apple_x = rand(GRID_WIDTH)
    @apple_y = rand(GRID_HEIGHT)
  end
end

snake = Snake.new
game = Game.new

update do
  clear 
  
  snake.move
  snake.draw
  game.draw

  if game.snake_eat_apple?(snake.x, snake.y)
    game.points
  end
end

on :key_down do |event|
  if ['up', 'down', 'left', 'right'].include?(event.key) 
    if snake.can_change_direction?(event.key)
    snake.direction = event.key
    end
  end
end

show