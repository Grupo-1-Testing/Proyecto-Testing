# frozen_string_literal: true

require_relative 'cell'

# Represents the board of mineseaker
class Board
  attr_accessor :dimension, :number_mines, :cells, :counter_creation_mines

  def initialize(dimension, number_mines)
    @dimension = dimension
    @number_mines = number_mines
    @counter_creation_mines = 0
    @cells = []
  end

  def create_board
    (0...@dimension).each do |_i|
      fila = []
      (0...@dimension).each do |_j|
        new_cell = create_cell
        fila.append(new_cell)
      end
      @cells.append(fila)
    end
  end

  def check_conditions; end

  def make_move; end

  def create_cell
    p = rand(1...100)
    if p <= 50 && @counter_creation_mines < @number_mines
      @counter_creation_mines += 1
      cell = Cell.new(true, '', '')
    else
      cell = Cell.new(false, '', '')
    end
    cell
  end
end
