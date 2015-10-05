class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    place_pieces

  end

  def place_pieces
    grid[0].map! do |square|
      square = Piece.new
    end
  end

end
