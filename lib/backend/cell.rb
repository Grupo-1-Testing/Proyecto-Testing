# frozen_string_literal: true

# Represents a position in the mineseaker board
class Cell
  attr_accessor :has_mine, :state, :value

  def initialize(has_mine, state, value)
    @has_mine = has_mine
    @state = state
    @value = value
  end

  def discover; end

  def flag; end
end
