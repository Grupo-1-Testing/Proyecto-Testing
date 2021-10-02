# frozen_string_literal: true

def get_first_cell(board)
  return board.cells[0][1] if board.cells[1][0].state == 'DISCOVERED'

  board.cells[1][0]
end
