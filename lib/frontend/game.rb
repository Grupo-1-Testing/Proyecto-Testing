# frozen_string_literal: true

require 'table_print'
require_relative '../backend/board'

# Represents the user interface used to play mineseaker
class Game
  DIMENSION = 11
  NMINES = 3

  def initialize
    @board = Board.new(DIMENSION, NMINES)
  end

  def play; end

  def print_board
    rows = []
    @board.cells.each_with_index do |row, row_idx|
      row_hash = { '#' => row_idx }
      row.each_with_index { |cell, col_idx| row_hash[col_idx.to_s] = cell_text(cell) }
      rows.push(row_hash)
    end
    tp rows
  end

  def cell_text(cell)
    case cell.state
    when 'CLOSED'
      'X'
    when 'DISCOVERED'
      cell.has_mine ? 'M' : cell.value.to_s
    else
      'F'
    end
  end

  def ask_movement; end

  def exit; end
end
