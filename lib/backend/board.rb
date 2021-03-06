# frozen_string_literal: true

require 'set'
require_relative 'cell'

# Represents the board of mineseaker
class Board
  attr_reader :dimension, :number_mines, :cells

  def initialize(dimension, number_mines, mine_cells = nil)
    @dimension = dimension
    @number_mines = number_mines
    @mine_cells = mine_cells || Array(0...@dimension * @dimension).sample(@number_mines)
    @cells = []
    @flagged_cells = 0
    create_board
    update_cell_values
    choose_start_cell
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
    directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
    directions.each do |direction|
      neighbour_x = row + direction[0]
      neighbour_y = col + direction[1]
      mine_counter += check_neighbour(neighbour_x, neighbour_y)
    end
    mine_counter
  end

  def check_neighbour(neighbour_x, neighbour_y)
    check_conditions = (
      neighbour_x.between?(0, @dimension - 1) &&
      neighbour_y.between?(0, @dimension - 1) &&
      @cells[neighbour_x][neighbour_y].has_mine
    )
    check_conditions ? 1 : 0
  end

  def check_flags(option)
    @flagged_cells == number_mines && option == '2'
  end

  def choose_start_cell
    random_start_cell = Array((0...@dimension**2).to_set - @mine_cells.to_set).sample(1)[0]
    @cells[random_start_cell.div(@dimension)][random_start_cell % @dimension].discover
  end

  def make_move(cell, move)
    case move
    when '1'
      cell.discover
    when '2'
      if !cell.state.eql?('DISCOVERED')
        cell.state.eql?('CLOSED') ? cell.flag : cell.unflag
        @flagged_cells += cell.state.eql?('FLAGGED') ? 1 : -1
      else
        puts 'You cant put a flag in a discoverd cell!'
        @flagged_cells
      end
    else
      raise 'Invalid value'
    end
    check_end_conditions(cell, move)
  end

  def validate_position(position)
    if (position.to_i.to_s == position) && position.to_i.between?(0, @dimension - 1)
      true
    else
      puts 'Invalid cell position. Try again.'
      false
    end
  end

  def check_end_conditions(cell, move)
    return false if cell.has_mine && cell.state != 'FLAGGED' && move == '1'

    cells.each do |row|
      row.each do |c|
        return 2 if c.state == 'CLOSED'
      end
    end
    3
  end
end
