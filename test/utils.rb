# frozen_string_literal: true

require_relative '../lib/backend/board'

def get_first_cell(board)
  return board.cells[0][1] if board.cells[1][0].state == 'DISCOVERED'

  board.cells[1][0]
end

def create_known_board
  mine_cells = [0, 3]
  Board.new(2, 2, mine_cells)
end
