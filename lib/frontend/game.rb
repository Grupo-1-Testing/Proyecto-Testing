# frozen_string_literal: true

require 'table_print'
require_relative '../backend/board'

# Represents the user interface used to play mineseaker
class Gamed
  DIMENSION = 3
  NMINES = 3

  def initialize
    @board = Board.new(DIMENSION, NMINES)
  end

  def play
    loop do
      print_board
      option = ask_move_option
      case option
      when '1', '2'
        break unless make_move(option)
      when '3'
        break
      else
        puts 'Invalid Option'
      end
    end
    puts 'Game Over'
  end

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

  def ask_move_option
    puts 'Choose play:',
         '(1) Discover cell',
         '(2) Flag cell',
         '(3) Exit'
    gets.chomp
  end

  def make_move(move)
    cell = ask_cell
    @board.make_move(cell, move)
    true
  end

  def ask_cell
    loop do
      print 'Choose Row: '
      cell_row = gets.chomp.strip
      print 'Choose Column: '
      cell_col = gets.chomp.strip
      if @board.validate_position(cell_row) && @board.validate_position(cell_col)
        return @board.cells[cell_row.to_i][cell_col.to_i]
      end
    end
  end
end
