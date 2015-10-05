class Piece
  attr_accessor :position, :board
  attr_reader :color
  def initialize(position, color, board)
    @position
    @board
  end

  def display
    "p"
  end

  def moves
  end

  def in_range?(pos)
    (0..7).include?(pos[0]) && (0..7).include?(pos[1])
  end

  def capturable?(pos)
    other = board[pos]
    !other.nil? && (other.color != color)
  end

end



class Pawn < Piece
  attr_accessor :first_move
  def initialize
    @first_move = true
  end

  def moves
    moves = []
    if first_move
      moves << [pos[0], pos[1] + 2]
      first_move = false
    end
    forward = [pos[0], pos[1] + 1]
    moves << forward if in_range?(forward)

    left_cap = [pos[0] - 1, pos[1] + 1]
    right_cap = [pos[0] + 1, pos[1] + 1]

    moves << left_cap if in_range?(left_cap) && capturable?(left_cap)
    moves << right_cap if in_range?(right_cap) && capturable?(right_cap)

    moves
  end

end
