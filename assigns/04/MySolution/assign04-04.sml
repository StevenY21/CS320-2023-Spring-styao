(* ****** ****** *)
use
"./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
//
HX-2023-02-16: 30 points
//
Here is an implementation of the famous 8-queen puzzle:
https://ats-lang.sourceforge.net/DOCUMENT/INT2PROGINATS/HTML/x631.html
//
Please give a NON-RECURSIVE implementation that solves the 8-queen puzzle.
//
type board_t =
int * int * int * int * int * int * int * int
//
fun
queen8_puzzle_solve(): board_t list =
//
*)

type board_t =
int * int * int * int * int * int * int * int

fun board_get
  (bd: board_t, i: int): int =
  if i = 1 then #1(bd)
  else if i = 2 then #2(bd)
  else if i = 3 then #3(bd)
  else if i = 4 then #4(bd)
  else if i = 5 then #5(bd)
  else if i = 6 then #6(bd)
  else if i = 7 then #7(bd)
  else if i = 8 then #8(bd)
  else ~1

fun board_set
  (bd: board_t, i: int, j:int): board_t = let
  val (x1, x2, x3, x4, x5, x6, x7, x8) = bd
in
  if i = 1 then let
    val x1 = j in (x1, x2, x3, x4, x5, x6, x7, x8)
  end else if i = 2 then let
    val x2 = j in (x1, x2, x3, x4, x5, x6, x7, x8)
  end else if i = 3 then let
    val x3 = j in (x1, x2, x3, x4, x5, x6, x7, x8)
  end else if i = 4 then let
    val x4 = j in (x1, x2, x3, x4, x5, x6, x7, x8)
  end else if i = 5 then let
    val x5 = j in (x1, x2, x3, x4, x5, x6, x7, x8)
  end else if i = 6 then let
    val x6 = j in (x1, x2, x3, x4, x5, x6, x7, x8)
  end else if i = 7 then let
    val x7 = j in (x1, x2, x3, x4, x5, x6, x7, x8)
  end else if i = 8 then let
    val x8 = j in (x1, x2, x3, x4, x5, x6, x7, x8)
  end else bd
end

fun safety_test1 (i0: int, j0: int, i: int, j: int) : bool =
(*
** [abs]: the absolute value function
*)
  if (j0 <> j) then 
    if (abs (i0 - i) <> abs (j0 - j)) then true else false
  else 
    if (j0 <= j) then false else true

fun safety_test2(i0: int, j0: int, bd: board_t, i: int) : bool =
  let
    val i_range = list_tabulate(i, fn(x) => x+1)
  in
    list_forall(i_range, fn(x) => if safety_test1(i0, j0, x, board_get(bd, x)) then true else false)
  end

fun board_get_boards(nx: board_t, i:int): board_t list = 
  if i = 1 then [board_set(nx,i,1),board_set(nx,i,2), board_set(nx,i,3), board_set(nx,i,4), board_set(nx,i,5), board_set(nx,i,6), board_set(nx,i,7), board_set(nx,i,8)]
  else
    let
      val valid_cols = list_filter([1,2,3,4,5,6,7,8], fn(x) => safety_test2(i,x,nx,i))
    in
      list_map(valid_cols, fn(x) => board_set(nx,i,x))
    end

fun queen8_puzzle_solve(): board_t list =
    let
        val start_board:board_t = (0,0,0,0,0,0,0,0)
        val all_boards = fn(n) => int1_foldleft(n, [start_board], fn(res,i) => list_concat(list_map(res, fn(nx) => board_get_boards(nx, i+1))))
    in
        all_boards(8)     
    end
(* ****** ****** *)
(* end of [CS320-2023-Spring-assign04-04.sml] *)
