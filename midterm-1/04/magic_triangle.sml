(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-01: midterm1-04: 10 points
*)
(* ****** ****** *)
(*
Magic Triangle:
             1
           1   1
         1   2   1
       1   3   3   1
     1   4   6   4   1
   1   5   10  10  5   1
 1   6   15  20  15  6   1

THe magic triangle has the following structure:
- All numbers on the left and right borders are 1.
- All numbers in the interior (non-border) are the sum of the
  numbers in the row directly above it.

The following example shows how row 5 is computed from row 4.

row 4:      1     4     6     4    1
           / \   / \   / \   / \  / \
row 5:    1   1+4   4+6   6+4  4+1   1


We can represent a magic triangle in SML as an int list list where each row
is stored as a nested int list.

row 0  [[1]
row 1   [1,  1]
row 2   [1,  2,  1]
row 3   [1,  3,  3,  1]
row 4   [1,  4,  6,  4,  1]
row 5   [1,  5,  10, 10, 5,  1]
row 6   [1,  6,  15, 20, 15, 6,  1]]
...


Please implement a function that produces a magic triangle with n row.

triangle 0 = [[1]]
triangle 1 = [[1], [1, 1]]
triangle 2 = [[1], [1, 1], [1, 2, 1]]
triangle 3 = [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1]]
triangle 4 = [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]]
...
triangle n = ???

Hint: You might want a helper function to compute the current row from
the previous.

*)

(* ****** ****** *)

(*
fun
magic_triangle (n : int) : int list list = ...
*)

(* ****** ****** *)
fun add_value(xs: int list, num: int, acc: int list): int list =
  case xs of 
    nil => acc
    | x1::xs => if xs = nil then add_value(xs, num, list_append(acc, [x1 + num])) else add_value(xs, num, acc)

fun get_tri_rows(xs:int list list, ys: int list list, acc: int list, n: int): int list = 
  case xs of
    nil => acc
    | x1::nil => get_tri_rows([[]], ys, list_append(acc,x1), n-1)
    | x1::xs => if acc = nil then get_tri_rows(xs, ys, list_append(list_append(acc,x1), x1), n-1) else get_tri_rows(xs, ys,list_append(add_value(ys,x1,acc),x1), n-1)

  case xs of
    nil => acc
    | x1::nil => get_tri_rows([[]],)

fun magic_triangle(n: int): int list list = 
  if n = 0 then [[1]]
  else 
    let 
      fun loop(n , acc: int list, count:int): int list list =
        if count > n then acc
        else 
            loop(n, list_append(acc, [get_tri_rows(acc, acc, [], count)]), count+1)
    in
      loop(n, [[1]], 0)
    end
(* end of [CS320-2023-Spring-midterm1-magic_triangle.sml] *)
