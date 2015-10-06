require 'colorize'
require 'io/console'
require 'byebug'
require_relative 'board'

class Display

  attr_accessor :board, :game, :cursor, :selected, :second_select

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
    @cursor = [0,0]
    @selected = nil
    @second_select = false

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
    handle_input(KEYMAP[input])
  end

def handle_input(input)
  self.second_select = false
  p input
  p self.selected
  p self.cursor
  sleep(0.5)
  if input == :up
    self.cursor[0] -= 1
  elsif input == :down
    self.cursor[0] += 1
  elsif input == :left
    self.cursor[1] -= 1
  elsif input == :right
    self.cursor[1] += 1
  elsif input == :select
    if !selected && (board[cursor].color == game.current_player.color)

      self.selected = cursor.dup

    elsif selected
      self.second_select = true
    end
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

        if el
          square = el.display.colorize(el.color).colorize( :background => bg )
        else
          square = " ".colorize(:white).colorize( :background => bg )
        end

        result << square

      end
      puts result
    end
    nil
  end

end

class CursorError < StandardError
end
