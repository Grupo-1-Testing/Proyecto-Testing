# frozen_string_literal: true

def make_moves(board)
  board.make_move(board.cells[1][0], '1')
  board.make_move(board.cells[0][0], '2')
end
