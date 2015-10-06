require_relative "board"
require_relative "display"
class Game
  attr_accessor :board, :display
  def initialize(board)
    @board = board
    @display = Display.new(board)
  end

  def play
    while true
      display.render
      display.get_input
      # board.move(board[selected_pos],cursor)
    end
  end

end
