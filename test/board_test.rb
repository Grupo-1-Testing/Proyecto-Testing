# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/backend/board'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def test_dimension
    dimension = 5
    number_mines = 1
    board = Board.new(dimension, number_mines)
    assert_equal(dimension, board.dimension)
  end

  def test_mine_count
    dimension = 4
    number_mines = 1
    board = Board.new(dimension, number_mines)
    count = 0
    board.cells.each do |row|
      row.each do |cell|
        count += 1 if cell.has_mine
      end
    end
    assert_equal(number_mines, count)
  end

  def test_mine_neighbours
    mine_cells = [0, 3]
    board = Board.new(2, 2, mine_cells)
    values = []
    board.cells.each do |row|
      row.each do |cell|
        values.append(cell.value)
      end
    end
    assert_equal([1, 2, 2, 1], values)
  end
end
