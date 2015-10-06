class Player
  attr_reader :color
  attr_accessor :display, :board

  def initialize(color,display,board)
    @color = color
    @display = display
    @board = board
  end

end


class HumanPlayer < Player

  def initialize(color,display,board)
    super
  end

  def play_turn
    turn_over = false
    
    until turn_over
      display.render
      display.get_input
      if display.selected && display.second_select
        # debugger
        turn_over = board.move(display.selected,display.cursor)
        display.selected = nil
      end
    end

  end
end
