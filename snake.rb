require 'ruby2d'

set background: 'olive'
set fps_cap: 20

GRID_SIZE = 20

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
      @positions.push([head[0], head[1] + 1])
    when 'up'
      @positions.push([head[0], head[0] - 1])
    when 'left'
      @positions.push([head[0] - 1, head[1]])
    when 'right'
      @positions.push([head[0] + 1, head[1]])
    end
  end
  
  private

  def head
    @positions.last
  end
end

snake = Snake.new

update do
  clear 
  
  snake.move
  snake.draw
end

on :key_down do |event|
  if['up', 'down', 'left', 'rigth'].include?(event.key) 
    snake.direction = event.key
  end
end

show