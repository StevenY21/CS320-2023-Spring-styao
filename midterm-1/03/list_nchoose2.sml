(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-01: midterm1-03: 10 points
*)
(* ****** ****** *)

(*
//
Given a list of distnct integers xs,
list_nchoose2(xs) returns a list of all
the pairs (x1, x2) such that x1 and x2 are
two elements from xs satisfying x1 <= x2.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//
For instance,
list_nchoose2([1,3,2]) =
[ (1,3), (1,2), (2,3) ]
list_nchoose2([3,2,1]) =
[ (2,3), (1,3), (1,2) ]
list_nchoose2([3,2,1,4]) =
[(2,3),(1,3),(1,2),(1,4),(2,4),(3,4)]
Note that the returned list is treated as a
set, and the order of the elements in the list
is insignificant.
*)

(* ****** ****** *)

(*
fun
list_nchoose2(xs: int list): (int * int) list = ...
*)

(* ****** ****** *)
fun pairs (x: int, xs: int list): (int * int) list = 
    case xs of 
        nil => nil
        | x1::xs => if x <= x1 then list_append([(x, x1)], pairs(x, xs)) else pairs(x,xs)
fun modify(ys: int list, pos: int, index: int): int list = 
    case ys of 
        nil=> nil
        | y1::ys => if index <> pos then y1::(modify(ys, pos, index+1)) else modify(ys, pos, index+1)

fun list_nchoose2(xs: int list): (int * int) list = 
    let
        val ys = xs
        fun all_pairs(xs, ys, pos:int): (int * int) list =
            case xs of
                nil => nil
                | x1::xs => list_append(pairs(x1, modify(ys, pos, 0)), all_pairs(xs,ys,pos+1))
    in 
        all_pairs(xs,ys,0)
    end

(* end of [CS320-2023-Spring-midterm1-list_nchoose2.sml] *)

