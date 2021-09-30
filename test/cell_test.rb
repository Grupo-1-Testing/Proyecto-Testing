# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/backend/cell'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def test_discover
    cell = Cell.new false
    cell.discover
    assert_equal('DISCOVERED', cell.state)
  end

  def test_flag
    cell = Cell.new false
    cell.flag
    assert_equal('FLAGGED', cell.state)
  end

  def test_die
    cell = Cell.new true
    still_alive = cell.discover
    assert(!still_alive)
  end
end
