require 'colorize'
require_relative "cursor"
require_relative "board"
require_relative "piece"

class Display

attr_reader :cursor, :board

def initialize(board)
  @board = board
  @cursor = Cursor.new([0,0], board)
end

def handle_input
  while true
    puts "\e[H\e[2J"
    render
    @cursor.get_input
  end
end

def render
  colored_board = colorize
  colored_board.each_with_index do |row, row_idx|
    puts row.join
  #  row.each_with_index do |el, el_idx|
  #   # print el
  #  end
  #  print "\n"
  end
  nil
end

def colorize
  colorized = []
  
  @board.grid.each_with_index do |row, row_idx|
    colorized_row = []

    row.each_with_index do |el, el_idx|
      #if @board[[row_idx, el_idx]]
      piece = "|#{@board[[row_idx, el_idx]].sym}|" # el.type.to_s

      if @cursor.cursor_pos == [row_idx, el_idx]
        colorized_row << piece.colorize(:color => :black, :background => :green)
      elsif el_idx.even? && row_idx.even? || el_idx.odd? && row_idx.odd?
        # el.type is an instance var in Piece class e.g., ":k"
        colorized_row << piece.colorize(:color => :black, :background => :white)
      else
        colorized_row << piece.colorize(:color => :white, :background => :black)
      end

    end
    colorized << colorized_row
  end

  colorized
end

end

