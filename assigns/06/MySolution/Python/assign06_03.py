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
  print((all_bds, 1))
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
  def gtree_dfs(nxs, fchlds):
    def helper(qnxs):
        if qnxs.empty():
            return strcon_nil()
        else:
            nx1 = qnxs.get()
            print("gtree_dfs: helper: nx1 = ", nx1)
            for nx2 in reversed(fchlds(nx1)):
                qnxs.put(nx2)
            return lambda: strcon_cons(nx1, lambda: helper(qnxs))
        # end-of-(if(qnxs.empty())-then-else)
    qnxs = queue.LifoQueue()
    for nx1 in nxs:
        qnxs.put(nx1)
    return lambda: helper(qnxs)
  def get_depth(bd):
     for i in len(bd):
        if bd[i] > 0:
           return i + 1
     return 0
  def next_boards(bds):
    if bds == board_tabulate(lambda x:0):
       return board_extend(bds, 0)
    bd_depth = get_depth(bds[0])
    return board_extend(bds, bd_depth)
  def find_next_board(curr, i):
    if i == N:
       if curr == []:
          return []
       else:
          for k in curr:
            print((k, 2))
            print((k in all_bds))
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
  all_bds = []
  next_board = find_next_board(oneQ_boards, 1)
  all_bds = all_bds + [next_board]
  dfs = lambda: gtree_dfs([board_tabulate(lambda x:0)], next_boards)
  return (next_board, all_bds)
  #return int1_foldleft(N, [board_tabulate(lambda x: 0)], lambda bds, i: pylist_concat(pylist_map_pylist(bds, lambda bd: board_extend(bd,i))))

def nqueen(bd):
    res = 0
    for j0 in bd:
        if j0 <= 0:
            break
        else:
            res = res + 1
    return res
def board_safety_all(bd):
    return \
        int1_forall\
        (nqueen(bd), \
         lambda i0: board_safety_one(bd, i0))
def board_safety_one(bd, i0):
    def helper(j0):
        pi = bd[i0]
        pj = bd[j0]
        return pi != pj and abs(i0-j0) != abs(pi-pj)
    return int1_forall(i0, helper)

def solve_N_queen_puzzle(N):
   all_bds = []
   return solve_N(N, all_bds)
def solve_N(N, all_bds):
  init_bd = N_queen_puzzle_solver(N, all_bds)
  return lambda: strcon_cons(init_bd[0], solve_N(N, init_bd[1]))
sol_8 = solve_N_queen_puzzle(8)
fxs = sol_8
cxs = fxs()
fxs = cxs.cons2
print(cxs.cons1)
"""
sol_8 = solve_N_queen_puzzle(16)
fxs = sol_8
cxs = fxs()
fxs = cxs.cons2
print(cxs.cons1)
print(board_safety_all(cxs.cons1))
cxs = fxs()
fxs = cxs.cons2
print(cxs.cons1)
print(board_safety_all(cxs.cons1))
"""
####################################################
