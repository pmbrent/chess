class Piece
  attr_accessor :position, :board
  def initialize(position, board)
    @position
    @board
  end

  def display
    "p"
  end

  def moves
  end
  
end

class SteppingPiece < Piece


end

class Pawn < Piece

end
