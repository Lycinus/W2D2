require "board"

class Piece

  def initialize(position, board)
    @position = position
    @board = board
  end

end

class Bishop < Piece
  include SlidingPiece

  attr_reader :directions, :board

  def initialize(position, board)
    super
    @directions = [:upleft, :upright, :downleft, :downright]
  end
end

module SlidingPiece
  DIR_DIFF = { 
      upleft: [-1, -1], 
      upright: [-1, 1],
      downleft: [1, -1],
      downright: [1, 1],
      up: [-1, 0],
      down: [1, 0],
      left: [0, -1],
      right: [0, 1]
    }

  def moves(curr_pos, directions)
    relevant_directions = DIR_DIFF.select { |k, v| directions.include?(k) }.values
    possible_moves = []

    relevant_directions.each do |dir|
      position = [curr_pos.first + dir.first, curr_pos.last + dir.last]

      until self.board[position].is_a?(Piece)
        possible_moves << position
        position = [position.first + dir.first, position.last + dir.last]
      end

    end

    possible_moves.select { |pos| Board.in_range?(pos) }
  end
end
