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

  def play
    continue = true

    while continue
      print_board
      continue = ask_movement
    end
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

  def ask_movement
    option = ask_move_option

    case option
    when '1', '2'
      make_move(option)
    when '3'
      exit
    else
      puts 'Por favor ingresar opción válida'
      ask_movement
    end
  end

  def ask_move_option
    puts 'Ingresa número de jugada:',
         '(1) Descubrir celda',
         '(2) Flag celda',
         '(3) Exit'

    gets.chomp
  end

  def make_move(move)
    cell = ask_cell
    @board.make_move(cell, move)
    true
  end

  def ask_cell
    puts 'Ingresa fila de celda:'
    cell_row = validate_cell(gets.chomp)

    puts 'Ingresa columna de celda:'
    cell_col = validate_cell(gets.chomp)

    @board.cells[cell_row][cell_col]
  end

  def validate_cell(position)
    if (position.to_i.to_s == position) && position.to_i.between?(0, @board.dimension - 1)
      position.to_i
    else
      puts 'Por favor ingresar número válido'
      ask_cell
    end
  end

  def exit
    puts 'Game Over'
    exit!
  end
end
