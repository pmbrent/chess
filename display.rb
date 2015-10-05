require 'colorize'
require 'io/console'
require_relative "board"

class Display

  attr_accessor :board, :game, :cursor, :selected

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

  def initialize(board)

    @board = board
    @game = game
    @cursor = [0,0]
    @selected = false

  end

  def get_input
    input = STDIN.getc
    raise CursorError.new("Invalid key") if !KEYMAP.include?(input)
  rescue CursorError => e
    puts e.message
    retry
  ensure
    handle_move(KEYMAP[input])
  end

def handle_move(input)
  if input == :up
    self.cursor[1] += 1
  elsif input == :down
    self.cursor[1] -= 1
  elsif input == :left
    self.cursor[0] -= 1
  elsif input == :right
    self.cursor[0] += 1
  elsif input == :select
    self.selected = !self.selected
  end
end

  def render
    board.grid.each_with_index do |row,idx|
      result = ""
      row.each_with_index do |el, idy|
        if [idx,idy] == cursor
          bg = :green
        else

          (idx + idy) % 2 == 0 ? bg = :light_blue : bg = :blue
        end

        el ? char = el.display : char = " "

        square = char.colorize(:white).colorize( :background => bg )

        result << square

      end
      puts result
    end
    nil
  end

end

class CursorError < StandardError
end
