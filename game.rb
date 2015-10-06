require_relative "board"
require_relative "display"

class Game
  attr_reader :players
  attr_accessor :board, :display, :current_player

  def initialize()
    @board = Board.new
    @display = Display.new(board,self)
    @players = [Player.new(:white), Player.new(:black)]
    @current_player = players[0]
  end

  def play

    game_over = false

    until game_over
      current_player.play_turn
      if current_player == players[0]
        current_player = players[1]
      else
        current_player = players[0]
      end
    end

  end

  def game_over
    # include draws later (3x repetition, 50-move?)
    return board.checkmate?(:white) || board.checkmate?(:black)
  end
end
