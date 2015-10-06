require_relative "piece"
require_relative "stepping_piece"
require_relative "sliding_piece"
require_relative "display"

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

  def piece_helper(pos, color)
    piece_array = [:r,:n,:b,:q,:k,:b,:n,:r]

    symb = piece_array[pos[1]]

    if symb == :r
      Rook.new(pos,color,self)
    elsif symb == :n
      Knight.new(pos,color,self)
    elsif symb == :b
      Bishop.new(pos,color,self)
    elsif symb == :q
      Queen.new(pos,color,self)
    elsif symb == :k
      King.new(pos,color,self)
    end

  end

  def place_pieces
    grid[0].each_index do |idx|
      pos = [0,idx]
      self[pos] = piece_helper(pos,:black)
    end
    grid[7].each_index do |idx|
      pos = [7,idx]
      self[pos] = piece_helper(pos,:white)
    end

    grid[1].each_index do |idx|
      pos = [1,idx]
      self[pos] = Pawn.new(pos,:black,self)
    end
    grid[6].each_index do |idx|
      pos = [6,idx]
      self[pos] = Pawn.new(pos,:white,self)
    end

  end

  def move(start,end_pos)
    moved = true

    begin
      if valid?(end_pos)
        raise PosError.new("Invalid end position")
      elsif self[start].nil?
        raise PosError.new("Invalid starting position")
      end
    rescue PosError => e
      puts e.message
      moved = false
    end

    if moved
      cur_piece = self[start]
      cur_piece.position = end_pos
      # handle if piece at end_pos
      self[end_pos] = cur_piece
      self[start] = nil
    end
    moved
  end

end



class PosError < StandardError

end
