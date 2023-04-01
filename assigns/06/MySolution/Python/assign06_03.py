####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../../mypylib')
from mypylib_cls import *
####################################################
"""
HX-2023-03-24: 20 points
Solving the N-queen puzzle
"""
import queue
####################################################

"""
Please revisit assign04-04.sml.
A board of size N is a tuple of length N.
######
For instance, a tuple (0, 0, 0, 0) stands
for a board of size 4 (that is, a 4x4 board)
where there are no queen pieces on the board.
######
For instance, a tuple (2, 1, 0, 0) stands
for a board of size 4 (that is, a 4x4 board)
where there are two queen pieces; the queen piece
on the 1st row is on the 2nd column; the queen piece
on the 2nd row is on the 1st column; the last two rows
contain no queen pieces.
######
This function [solve_N_queen_puzzle] should return
a stream of ALL the boards of size N that contain N
queen pieces (one on each row and on each column) such
that no queen piece on the board can catch any other ones
on the same board.
"""
# translate the code obv at https://piazza.com/class/lcs4abvjqr620t/post/677
# use gtree_dfs to enumerate all the valid board configs 
# check this for gtree stuff https://piazza.com/class/lcs4abvjqr620t/post/1000
def N_queen_puzzle_solver(N, all_bds):
  #print((all_bds, 1))
  def board_foreach(bd, work):
    return tuple(work(bd[i]) for i in range(len(bd)))
  def board_get_at(bd, i):
    return bd[i]
  def board_tabulate(f):
    return tuple(f(i) for i in range(N))
  def board_fset_at(bd, i, p):
    return board_tabulate(lambda j: p if i == j else board_get_at(bd, j))
  def board_safety(bd, i):
    pi = board_get_at(bd,i)
    def helper(j):
      pj = board_get_at(bd, j)
      return (pi != pj) and (abs(i-j) != abs(pi-pj))
    return int1_forall(i, lambda j: helper(j))
  def int1_map_list(xs, fopr):
    return foreach_to_map_pylist(int1_foreach)(xs, fopr)
  def board_extend(bd, i):
    return pylist_filter_pylist(int1_map_list(N, lambda p: board_fset_at(bd, i, p+1)), lambda bd: board_safety(bd, i))
  def find_next_board(curr, i):
    if i == N:
       if curr == []:
          return []
       else:
          for k in curr:
            # print((k, 2))
            if (k in all_bds) == False:
              return k
          return []
    else:
      for j in range(len(curr)):
        #print((curr[j], i))
        next = board_extend(curr[j], i)
        #print(next)
        if next != []:
          result = find_next_board(next, i+1)
          #print((result, i))
          if result != []:
             return result
          elif j == len(curr)-1:
             return []
      return []
  oneQ_boards = board_extend(board_tabulate(lambda x: 0), 0)
  next_board = find_next_board(oneQ_boards, 1)
  all_bds = all_bds + [next_board]
  return (next_board, all_bds)
  #return int1_foldleft(N, [board_tabulate(lambda x: 0)], lambda bds, i: pylist_concat(pylist_map_pylist(bds, lambda bd: board_extend(bd,i))))

def solve_N_queen_puzzle(N):
  all_bds = []
  return solve_N(N, all_bds)
def solve_N(N, all_bds):
  init_bd = N_queen_puzzle_solver(N, all_bds)
  if init_bd[0] == []:
    return lambda: strcon_nil()
  else:
    return lambda: strcon_cons(init_bd[0], solve_N(N, init_bd[1]))
####################################################
