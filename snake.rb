require 'ruby2d'

set background: 'olive'

GRID_SIZE = 20

class Snake
  def initialize
    @positions = [[2, 0],[2, 1], [2, 2], [2, 3]] 
  end

  def draw
    @positions.each do |position|
      Square.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: GRID_SIZE, color: 'orange')
    end
  end
end

snake = Snake.new
snake.draw

show