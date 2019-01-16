require_relative "board"
require 'singleton'

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
        #Add condition for if position is held by either player
        Board.in_range?(position) ? possible_moves << position : break 
        position = [position.first + dir.first, position.last + dir.last]
      end

    end

    possible_moves #.select { |pos| Board.in_range?(pos) }
  end
end

module SteppingPiece
  DIFF = {
      knight: [[-1, -2], [1, 2], [-1, 2], [1, -2], [-2, -1], [2, 1], [-2, 1], [2, -1]],
      king: [[0,1], [1,0], [-1,0], [0, -1], [-1,-1], [1, 1], [-1,1],[1,-1]]
    }
  
  def moves(curr_pos)
    possible_moves = []
    self.is_a?(Knight) ? relevant_directions = DIFF[:knight] : relevant_directions = DIFF[:king]

    relevant_directions.each do |dir|
      #Add condition for if position is held by either player
      shifted = [curr_pos[0] + dir[0], curr_pos[1] + dir[1]]
      if Board.in_range?(shifted) && !self.board[shifted].is_a?(Piece)
        possible_moves << shifted 
      end
    end
    possible_moves

  end

end

class Piece

  attr_reader :position, :board, :color, :sym

  def initialize(position, board)
    @position = position
    @board = board
    @color = :black
    @sym = self.class.to_s[0..1]
  end

end

class Bishop < Piece
  include SlidingPiece

  attr_reader :directions

  def initialize(position, board)
    super
    @directions = [:upleft, :upright, :downleft, :downright]
  end

  def possible_moves
    moves(self.position, self.directions)
  end
end

class Rook < Piece
  include SlidingPiece

  attr_reader :directions

  def initialize(position, board)
    super
    @directions = [:up, :down, :left, :right]
  end

  def possible_moves
    moves(self.position, self.directions)
  end
end 

class Queen < Piece
  include SlidingPiece

  attr_reader :directions

  def initialize(position, board)
    super
    @directions = [:up, :down, :left, :right, :upleft, :upright, :downleft, :downright]
  end

  def possible_moves
    moves(self.position, self.directions)
  end
end 

class Knight < Piece
  include SteppingPiece

  def possible_moves
    moves(self.position)
  end
end

class King < Piece
  include SteppingPiece

  def possible_moves 
    moves(self.position)
  end
end

class Pawn < Piece
  attr_reader :first_move

  def initialize(position, board)
    super
    @first_move = true

  end

  def possible_moves
    moves = []

    if self.first_move
      moves << [self.position.first - 2, self.position.last]
      moves << [self.position.first - 1, self.position.last]
    else
      moves << [self.position.first - 1, self.position.last]
    end

    moves.select { |pos| !self.board[pos].is_a?(Piece) }
  end
end

class NullPiece
  include Singleton

  attr_reader :sym

  def initialize
    @sym = "  "
  end

  # attr_reader :position, :board
  
  # def initialize(position, board)
  #   @position = position
  #   @board = board
  # end
end
