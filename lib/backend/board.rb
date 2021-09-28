# frozen_string_literal: true

require_relative 'cell'

# Represents the board of mineseaker
class Board
  attr_accessor :dimension, :number_mines, :cells, :mine_cells

  def initialize(dimension, number_mines)
    @dimension = dimension
    @number_mines = number_mines
    @mine_cells = Array(0...@dimension * @dimension).sample(@number_mines).sort
    @cells = []
  end

  def create_board
    (0...@dimension).each do |i|
      row = []
      (0...@dimension).each do |j|
        cell_number = j + i * @dimension
        new_cell = create_cell(cell_number)
        row.append(new_cell)
      end
      @cells.append(row)
    end
  end

  def create_cell(cell_number)
    has_bomb = @mine_cells.include?(cell_number)
    Cell.new(has_bomb, '', '')
  end

  def check_conditions; end

  def make_move; end
end
