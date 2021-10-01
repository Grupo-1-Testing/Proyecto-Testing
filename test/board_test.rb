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

  def test_check_flags_true
    board = Board.new(2, 1)
    cell = board.cells.first.first
    board.make_move(cell, '2')
    result = board.check_flags('2')
    assert_equal(result, true)
  end

  def test_check_flags_false
    board = Board.new(2, 2)
    cell = board.cells.first.first
    board.make_move(cell, '2')
    result = board.check_flags('2')
    assert_equal(result, false)
  end

  def test_make_discover_move
    board = Board.new(2, 2)
    cell = board.cells.first.first
    board.make_move(cell, '1')
    assert_equal(cell.state, 'DISCOVERED')
  end

  def test_make_flag_move
    board = Board.new(2, 2)
    cell = board.cells.first.first
    board.make_move(cell, '2')
    assert_equal(cell.state, 'FLAGGED')
  end

  def test_make_invalid_move
    board = Board.new(2, 2)
    cell = board.cells.first.first
    board.make_move(cell, '9')
    assert(false)
  rescue StandardError
    assert(true)
  end

  def test_validate_position_user_enters_a_letter
    dimension = 4
    number_mines = 1
    board = Board.new(dimension, number_mines)
    result = board.validate_position('a')
    assert_equal(false, result)
  end

  def test_validate_position_user_enters_out_of_dimension_value
    dimension = 4
    number_mines = 1
    board = Board.new(dimension, number_mines)
    result = board.validate_position('8')
    assert_equal(false, result)
    result = board.validate_position('-1')
    assert_equal(false, result)
  end

  def test_validate_position_user_enters_correct_value
    dimension = 4
    number_mines = 1
    board = Board.new(dimension, number_mines)
    result = board.validate_position('2')
    assert_equal(true, result)
  end

  def test_check_end_conditions_lose
    mine_cells = [0, 3]
    board = Board.new(2, 2, mine_cells)
    cell = board.cells.first.first
    result = board.check_end_conditions(cell, '1')
    assert_equal(result, 1)
  end

  def test_check_end_conditions_continue_playing
    mine_cells = [0, 3]
    board = Board.new(2, 2, mine_cells)
    cell = board.cells.first.last
    result = board.check_end_conditions(cell, '1')
    assert_equal(result, 2)
  end

  def test_check_end_conditions_win_last_move_discover
    mine_cells = [0]
    board = Board.new(2, 1, mine_cells)
    cell = board.cells.first.first
    board.make_move(cell, '2')
    cell = board.cells.first.last
    board.make_move(cell, '1')
    cell = board.cells.last.first
    board.make_move(cell, '1')
    cell = board.cells.last.last
    board.make_move(cell, '1')
    result = board.check_end_conditions(cell, '1')
    assert_equal(result, 3)
  end

  def test_check_end_conditions_win_last_move_flag
    mine_cells = [0]
    board = Board.new(2, 1, mine_cells)
    cell = board.cells.first.last
    board.make_move(cell, '1')
    cell = board.cells.last.first
    board.make_move(cell, '1')
    cell = board.cells.last.last
    board.make_move(cell, '1')
    board.check_end_conditions(cell, '1')
    cell = board.cells.first.first
    result = board.make_move(cell, '2')
    assert_equal(result, 3)
  end
end
