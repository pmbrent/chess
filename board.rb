class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    place_pieces
  end

  def [](pos)
    x,y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    grid[x][y] = value
  end

  def place_pieces
    rows = [0,1,6,7]
    rows.each do |idx|
      fill_row(grid[idx])
    end

  end

  def fill_row(row)
    row.map! do |square|
      square = Piece.new
    end
  end

  def move(start,end_pos)
    begin
      if valid?(end_pos)
        raise PosError.new("Invalid end position")
      elsif self[start].nil?
        raise PosError.new("Invalid starting position")
      end
    rescue PosError => e
      puts e.message
      retry
    end

    cur_piece = self[start]
    cur_piece.position = end_pos
    # handle if piece at end_pos
    self[end_pos] = cur_piece
    self[start] = nil

end



class PosError < StandardError

end
