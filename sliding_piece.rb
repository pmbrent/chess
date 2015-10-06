class SlidingPiece < Piece
  def initialize(position, color, board)
    super(position, color, board)
    @diagonal = nil
    @horiz_vert = nil
  end

  def horiz_vert?
    @horiz_vert
  end

  def diagonal?
    @diagonal
  end

  def moves
    moves = []
    dirs = []

    if diagonal?
      dirs += [[1,1],
               [1,-1],
               [-1,1],
               [-1,-1]]
    end

    if horiz_vert?
      dirs += [[0,1],
              [0,-1],
              [1,0],
              [-1,0]]
    end

    dirs.map do |dir|
        pos = position
        go = true
        while in_range?(pos) && go
          if !board[pos].nil?
            go = false
            capturable?(pos) ? nil : next
          end
        moves << pos unless pos == position
        pos = pos[0] + dir[0], pos[1] + dir[1]
        end
      end

      moves
  end

end

class Bishop < SlidingPiece
  def initialize(position, color, board)
    super
    @diagonal = true
    @horiz_vert = false
  end

  def display
    "B"
  end

end

class Rook < SlidingPiece
  def initialize(position, color, board)
    super
    @diagonal = false
    @horiz_vert = true
  end
  def display
    "R"
  end

end

class Queen < SlidingPiece
  def initialize(position, color, board)
    super
    @diagonal = true
    @horiz_vert = true
  end
  def display
    "Q"
  end

end
