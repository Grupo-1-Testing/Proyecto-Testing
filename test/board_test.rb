# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/backend/board'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def test_dimension
    board = Board.new(5, 1)
    assert_equal(5, board.dimension)
  end

  def test_mine_count
    board = Board.new(4, 1)
    count = 0
    board.cells.each do |row|
      row.each do |cell|
        count += 1 if cell.has_mine
      end
    end
    assert_equal(1, count)
  end

  def test_mine_neighbours
    board = Board.new(2, 2, [0, 3])
    values = []
    board.cells.each do |row|
      row.each do |cell|
        values.append(cell.value)
      end
    end
    assert_equal([1, 2, 2, 1], values)
  end

  def test_check_flags_true
    board = Board.new(2, 1, [0])
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
    board = Board.new(2, 1, [0])
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
    board = Board.new(4, 1)
    result = board.validate_position('a')
    assert_equal(false, result)
  end

  def test_validate_position_user_enters_out_of_dimension_value
    board = Board.new(4, 1)
    result = board.validate_position('8')
    assert_equal(false, result)
    result = board.validate_position('-1')
    assert_equal(false, result)
  end

  def test_validate_position_user_enters_correct_value
    board = Board.new(4, 1)
    result = board.validate_position('2')
    assert_equal(true, result)
  end

  def check_end_conditions(cell)
    return false if cell.has_mine && cell.state != 'FLAGGED'

    cells.each do |row|
      row.each { |c| return true if c.state == 'CLOSED' }
    end
    false
  end

  def test_check_end_conditions_lose
    board = Board.new(2, 2, [0, 3])
    cell = board.cells.first.first
    result = board.check_end_conditions(cell, '1')
    assert_equal(result, false)
  end

  def test_check_end_conditions_win
    board = Board.new(2, 1, [0])
    Array(0..1).each do |row|
      Array(0..1).each do |col|
        move = '1'
        move = '2' if row.zero? && col.zero?
        cell = board.cells[row][col]
        board.make_move(cell, move)
      end
    end
    cell = board.cells.last.last
    result = board.check_end_conditions(cell, '1')
    assert_equal(result, 3)
  end

  def test_check_flags_limit
    board = Board.new(2, 2, [0, 3])
    board.make_move(board.cells[0][0], '2')
    board.make_move(board.cells[1][1], '2')
    check = board.check_flags('2')
    assert_equal(true, check)
  end

  def test_check_flags
    board = Board.new(2, 2, [0, 3])
    board.make_move(board.cells[0][0], '2')
    check = board.check_flags('2')
    assert_equal(false, check)
  end

  def test_check_unflag
    board = Board.new(2, 2, [0])
    board.make_move(board.cells[0][0], '2')
    board.make_move(board.cells[0][0], '2')
    check = board.cells[0][0].state
    assert_equal('CLOSED', check)
  end

  def test_flag_discovered_cell
    board = Board.new(2, 2, [0])
    board.make_move(board.cells[0][1], '1')
    board.make_move(board.cells[0][1], '2')
    check = board.cells[0][1].state
    assert_equal('DISCOVERED', check)
  end

  def test_make_move_discover_valid_cell
    board = Board.new(2, 2, [0, 3])
    cell = board.cells[1][0].state == 'DISCOVERED' ? board.cells[0][1] : board.cells[1][0]
    result = board.make_move(cell, '1')
    assert_equal('DISCOVERED', cell.state)
    assert_equal(2, result)
  end

  def test_make_move_discover_mine
    board = Board.new(2, 2, [0, 3])
    cell = board.cells[0][0]
    result = board.make_move(cell, '1')
    assert_equal('DISCOVERED', cell.state)
    assert_equal(false, result)
  end

  def test_make_move_flag_cell
    board = Board.new(2, 2, [0, 3])
    cell = board.cells[1][0].state == 'DISCOVERED' ? board.cells[0][1] : board.cells[1][0]
    result = board.make_move(cell, '2')
    assert_equal('FLAGGED', cell.state)
    assert_equal(2, result)
  end
end
