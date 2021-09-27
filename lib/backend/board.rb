# frozen_string_literal: true

# Represents the board of mineseaker
class Board
  attr_reader :dimension

  def initialize(dimension)
    @dimension = dimension
    @cells = []
  end

  def create_board; end

  def check_conditions; end

  def make_move; end
end
