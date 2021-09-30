# frozen_string_literal: true

# Represents a position in the mineseaker board
class Cell
  attr_reader :has_mine, :state
  attr_accessor :value

  def initialize(has_mine)
    @has_mine = has_mine
    @state = 'CLOSED'
  end

  def discover
    @state = 'DISCOVERED'
    !has_mine
  end

  def flag
    @state = 'FLAGGED'
  end
  def unflag
    @state = 'CLOSED'
  end
end
