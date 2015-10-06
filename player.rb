class Player
  attr_reader :color
  
  def initialize(color,display,board)
    @color = color
    @display = display
    @board = board
  end

end


class HumanPlayer << Player

  def initialize(color,display,board)
    super
  end

  def play_turn
    turn_over = false
    until turn_over
      display.render
      display.get_input
      if display.selected? && display.last_input_select
        turn_over = board.move(display.selected,display.cursor)
      else
        display.selected = nil
      end
    end

  end
