# frozen_string_literal: true

require_relative '../backend/board'

# Represents the user interface used to play mineseaker
class Game
  DIMENSION = 10

  def initialize
    @board = Board.new(DIMENSION)
  end

  def print_board; end

  def ask_movement; end

  def exit; end
end
