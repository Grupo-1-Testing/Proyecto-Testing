# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/backend/board'
require 'test/unit'

class ClockTest < Test::Unit::TestCase
  def test_zero
    dimension = 5
    board = Board.new(dimension)
    assert_equal(dimension, board.dimension)
  end
end
