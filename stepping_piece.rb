class SteppingPiece < Piece

  def moves
    moves = []
    dirs = move_dirs



    dirs.map do |dir|
        pos = position
        pos = pos[0] + dir[0], pos[1] + dir[1]
        moves << pos if in_range?(pos)
    end

    moves
  end
end

class Knight < SteppingPiece

  def display
    "N"
  end

  def move_dirs
    [
     [-2, -1],
     [-2,  1],
     [-1, -2],
     [-1,  2],
     [ 1, -2],
     [ 1,  2],
     [ 2, -1],
     [ 2,  1]
   ]

  end
end

class King < SteppingPiece

  def display
    "K"
  end
  def move_dirs
    [
      [0,1],
      [1,0],
      [1,1],
      [0,-1],
      [-1,0],
      [-1,-1],
      [-1,1],
      [1,-1]
    ]
  end
end
