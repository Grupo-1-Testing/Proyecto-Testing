# frozen_string_literal: true

require 'table_print'
require_relative '../backend/board'

# Represents the user interface used to play mineseaker
class Game
  DIMENSION = 3
  NMINES = 3

  def initialize
    @board = Board.new(DIMENSION, NMINES)
  end

  def play
    loop do
      print_board
      option = ask_move_option
      if @board.check_flags
        puts 'You dont have more flags.'
        option = ask_move_option
      end
      case option
      when '1', '2'
        break unless make_move(option)
      when '3'
        break
      else
        puts 'Invalid Option'
      end
    end
    print_board
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
    result = @board.make_move(cell, move)
    unless result
      puts 'Perdiste. Qué triste :('
      return false
    end
    true
  end

  def ask_cell
    loop do
      print 'Choose Row: '
      cell_row = gets.chomp.strip
      print 'Choose Column: '
      cell_col = gets.chomp.strip
      return @board.cells[cell_row.to_i][cell_col.to_i] if validate_position(cell_row) && validate_position(cell_col)
    end
  end

  def validate_position(position)
    if (position.to_i.to_s == position) && position.to_i.between?(0, @board.dimension - 1)
      true
    else
      puts 'Invalid cell position. Try again.'
      false
    end
  end
end
