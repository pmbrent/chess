require 'colorize'
require 'io/console'

class Display

  attr_accessor :board, :game

  KEYMAP = {
    "w" => :up,
    "a" => :left,
    "s" => :down,
    "d" => :right,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,
    " " => :select,
    "\r" => :select
  }

  def initialize(board,game)

    @board = board
    @game = game

  end

  def get_input
    input = STDIN.getc
    raise CursorError.new("Invalid key") if !KEYMAP.include?(input)
  rescue CursorError => e
    puts e.message
    retry
  end


end

class CursorError < StandardError
end
