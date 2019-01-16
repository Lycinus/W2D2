require_relative "piece"

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    # starting_rows = [0,1,6,7]
    # starting_rows.each { |row| @grid[row].map!.with_index { |el, idx| Piece.new([row, idx], self) } }
    pieces = {
      'King'=> [[0, 4], [7,4]],
      'Queen'=> [[0,3], [7,3]],
      'Bishop'=> [[0,2], [0,5], [7,2], [7,5]],
      'Knight'=> [[0,1], [0,6], [7,1], [7,6]],
      'Rook'=> [[0,0], [0,7], [7,0], [7,7]],
      'Pawn'=> Array.new(8) { |n| [1, n] }.concat( Array.new(8) { |n| [6, n] } )
    }
    
    pieces.each do |piece, all_pos|
      all_pos.each do |pos|
        self[pos] = Object.const_get(piece).new(pos, self)
      end
    end

    (2..5).each do |row|
      (0..7).each do |el_idx|
        self[[row,el_idx]] = NullPiece.instance
      end
    end
  end


  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x,y = pos
    @grid[x][y] = val
  end

  def self.in_range?(pos)
    #out of range
    return false if !(0..7).include?(pos[0]) || !(0..7).include?(pos[1])

    true
  end


  def move_piece(start_pos, end_pos)
   
    if self[start_pos] == nil
      raise "There is no piece at the start position."
    end

    if self[end_pos]
      raise "That position is already filled."
    end


    self[end_pos] = self[start_pos]
    self[start_pos] = nil

  end

end
