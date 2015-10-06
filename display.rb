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
    @selected = [0,0]

  end


  def get_input
    input = ''
    # system("stty raw -echo")
    STDIN.raw do |stdin|
      input = stdin.getc
      if input == "\e" then
            input << STDIN.read_nonblock(3) rescue nil
            input << STDIN.read_nonblock(2) rescue nil
      end

    end
    raise CursorError.new("Invalid key") if !KEYMAP.include?(input)
  rescue CursorError => e
    puts e.message
    retry
  ensure
    # system("stty -raw echo")
    handle_move(KEYMAP[input])
  end

def handle_move(input)
  if input == :up
    self.cursor[0] -= 1
  elsif input == :down
    self.cursor[0] += 1
  elsif input == :left
    self.cursor[1] -= 1
  elsif input == :right
    self.cursor[1] += 1
  elsif input == :select
    if self.selected
      self.selected = nil
    else
      self.selected = cursor
    end
end


  def render
    system("clear")
    board.grid.each_with_index do |row,idx|
      result = ""
      row.each_with_index do |el, idy|
        if [idx,idy] == cursor
          bg = :green
        elsif [idx,idy] == selected
          bg = :red
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
