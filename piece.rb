class Piece
  attr_accessor :position, :board
  attr_reader :color

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
  end

  def display
    raise NotImplementedError
  end

  def moves
    raise NotImplementedError
  end

  def in_range?(pos)
    (0..7).include?(pos[0]) && (0..7).include?(pos[1])
  end

  def capturable?(pos)
    other = board[pos]
    !other.nil? && (other.color != color)
  end

  def move_into_check?(pos)
    copy_board = board.dup

    copy_board.move!(position,pos)
    copy_board.in_check?(color)
  end

  def valid_moves

    all_moves = moves
    valid_moves = all_moves.select { |move| !move_into_check?(move)}
    
    valid_moves

  end

end



class Pawn < Piece
  attr_accessor :first_move
  def initialize(position, color, board)
    super
    @first_move = true
  end

  def display
    "p"
  end

  def moves
    if self.color == :white
      moves_white
    else
      moves_black
    end
  end

  def moves_white
    moves = []
    if first_move
      moves << [position[0] - 2, position[1]]
      self.first_move = false
    end
    forward = [position[0] - 1, position[1]]
    moves << forward if in_range?(forward)

    left_cap = [position[0] - 1, position[1] - 1]
    right_cap = [position[0] - 1, position[1] + 1]

    moves << left_cap if in_range?(left_cap) && capturable?(left_cap)
    moves << right_cap if in_range?(right_cap) && capturable?(right_cap)

    moves
  end

  def moves_black
    moves = []
    if first_move
      moves << [position[0] + 2, position[1]]
      self.first_move = false
    end
    forward = [position[0] + 1, position[1]]
    moves << forward if in_range?(forward)

    left_cap = [position[0] + 1, position[1] - 1]
    right_cap = [position[0] + 1, position[1] + 1]

    moves << left_cap if in_range?(left_cap) && capturable?(left_cap)
    moves << right_cap if in_range?(right_cap) && capturable?(right_cap)

    moves
  end

end
