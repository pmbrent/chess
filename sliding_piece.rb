require_relative 'piece'

class SlidingPiece < Piece
  def initialize(position, board)
    super(position, board)
    @diagonal = nil
    @horiz_vert = nil
  end

  def horiz_vert?
    @horiz_vert
  end

  def diagonal?
    @diagonal
  end

  def in_range?(pos)
    (0..7).include?(pos[0]) && (0..7).include?(pos[1])
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
        while in_range?(pos)
        moves << pos unless pos == position
        pos = pos[0] + dir[0], pos[1] + dir[1]
        end
      end

      moves
  end

end

class Bishop < SlidingPiece
  def initialize(position, board)
    super(position, board)
    @diagonal = true
    @horiz_vert = false
  end

end

class Rook < SlidingPiece
  def initialize(position, board)
    super(position, board)
    @diagonal = false
    @horiz_vert = true
  end

end

class Queen < SlidingPiece
  def initialize(position, board)
    super(position, board)
    @diagonal = true
    @horiz_vert = true
  end

end
