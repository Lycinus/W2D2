require_relative "board"

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
        Board.in_range?(position) ? possible_moves << position : break
        position = [position.first + dir.first, position.last + dir.last]
      end

    end

    possible_moves #.select { |pos| Board.in_range?(pos) }
  end
end

class Piece

  def initialize(position, board)
    @position = position
    @board = board
  end

end

class Bishop < Piece
  include SlidingPiece

  attr_reader :directions, :board, :position

  def initialize(position, board)
    super
    @directions = [:upleft, :upright, :downleft, :downright]
  end

  def move_piece
    moves(self.position, self.directions)
  end
end

class Rook < Piece
  include SlidingPiece

  attr_reader :directions, :board, :position

  def initialize(position, board)
    super
    @directions = [:up, :down, :left, :right]
  end

  def move_piece
    moves(self.position, self.directions)
  end
end 

class Queen < Piece
  include SlidingPiece

  attr_reader :directions, :board, :position

  def initialize(position, board)
    super
    @directions = [:up, :down, :left, :right, :upleft, :upright, :downleft, :downright]
  end

  def move_piece
    moves(self.position, self.directions)
  end
end 

