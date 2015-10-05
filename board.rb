require_relative "piece"
require "byebug"
class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    place_pieces
  end

  def [](pos)
    x,y = pos
    # debugger
    grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    grid[x][y] = value
  end

  def place_pieces
    rows = [0,1,6,7]
    grid.each_index do |idr|
      if rows.include?(idr)
        grid[idr].each_index do |idy|
        pos = [idr,idy]
        self[pos] = Piece.new(pos)
        end
      end
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

end



class PosError < StandardError

end
