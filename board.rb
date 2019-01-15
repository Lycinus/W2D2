require_relative "piece"

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    # starting_rows = [0,1,6,7]
    # starting_rows.each { |row| @grid[row].map! { |el| Piece.new } }
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
