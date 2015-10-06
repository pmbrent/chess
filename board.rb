require_relative "piece"
require_relative "stepping_piece"
require_relative "sliding_piece"
require_relative "display"
require_relative "player"

require "byebug"

class Board

  attr_accessor :grid

  def initialize(filled = true)
    @grid = Array.new(8) { Array.new(8) }
    place_pieces if filled
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

  def in_check?(color)
    king_p = king_pos(color)
    opp_pieces = []
    self.grid.each do |row|
      row.each do |el|
        if el && (el.color != color)
          opp_pieces << el
        end
      end
    end
    opp_pieces.any? {|opp_piece| opp_piece.moves.include? king_p}
  end

  def king_pos(color)
    pos = nil

    self.grid.each do |row|
      row.each do |el|
        if el.is_a?(King) && el.color == color
          pos = el.position
        end
      end
    end
    pos
  end

  def checkmate?(color)
    return false if !in_check?(color)

    own_pieces = []
    self.grid.each do |row|
      row.each do |el|
        if el && (el.color == color)
          own_pieces << el
        end
      end
    end

    own_pieces.all? { |own_piece| own_piece.valid_moves.nil? }

  end

  def dup
    new_board = Board.new(false)
    grid.each do |row|
      row.each do |el|
        next if !el
        new_board[el.position] = el.class.new(el.position,el.color,new_board)
      end
    end
    new_board

  end


  private

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

end



class PosError < StandardError

end
