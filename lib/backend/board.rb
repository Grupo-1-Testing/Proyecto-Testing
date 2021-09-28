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
    update_cell_values
  end

  def create_cell(cell_number)
    has_bomb = @mine_cells.include?(cell_number)
    Cell.new(has_bomb)
  end

  def update_cell_values
    (0...@dimension).each do |i|
      (0...@dimension).each do |j|
        mine_counter = count_mine_neigbours(i, j)
        @cells[i][j].value = mine_counter
      end
    end
  end

  def count_mine_neigbours(row, col, mine_counter = 0)
    (-1...1).each do |x|
      (-1...1).each do |y|
        neighbor_x = row + x
        neighbor_y = col + y
        if neighbor_x.between?(0, @dimension - 1) && neighbor_y.between?(0, @dimension - 1) && !(x.zero? && y.zero?)
          mine_counter += @cells[neighbor_x][neighbor_y].has_mine ? 1 : 0
        end
      end
    end
    mine_counter
  end

  def check_conditions; end

  def make_move; end
end
