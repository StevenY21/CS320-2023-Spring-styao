(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-02: midterm-06: 20 points
//
Given a list of integers xs, list_grouping(xs)
returns a list of pairs (n, x) where n indicates
the number of times x occurs in xs; for each x in
xs, there must be a pair (n, x) for some n in the
returned list.
//
For instance,
list_grouping([1,2]) = [[1,1], [1,2]]
list_grouping([1,2,2,2,1]) = [[2,1], [3,2]]
list_grouping([1,2,1,2,3]) = [[2,1], [2,2], [1,3]]
//
In order to receive full credit, your implementation
should be able to handle a list containing 1M elements
in less than 10 seconds (mine can do it in less than
two seconds)
//
*)
(* ****** ****** *)

(*
fun
list_grouping(xs: int list): (int * int) list = ...
*)
fun count(xs: int list, x:int, ys: int list, total:int): int * int list = 
    case xs of 
        nil => (total, ys)
        | x1::xs => if x1 = x then count(xs,x,ys,total+1) else count(xs,x,list_append(ys, [x1]),total)


fun remove_counted(x:int, xs:int list, acc: int list): int list = 
    case xs of
        nil => acc
        | x1::xs => if x1 = x then remove_counted(x, xs, acc) else remove_counted(x, xs, list_append(acc, [x1]))
fun list_grouping(xs: int list): (int * int) list = 
    let 
        fun loop(xs:int list, acc: (int * int) list): (int * int) list = 
            case xs of 
                nil => acc
                | x1::xs => 
                    let 
                        val counted = count(xs, x1, [], 1)
                    in
                        loop(#2(counted), list_append(acc, [(#1(counted), x1)]))
                    end
    in 
        loop(xs, [])
    end

(* ****** ****** *)

(*
Some testing code:
val N = 1000
val nxs = list_grouping(int1_map_list(N, fn i => N-i))
*)
(* ****** ****** *)

(*
Some testing code:
Your implementation needs to be efficient to pass the
following test:
val N = 1000000
val nxs = list_grouping(int1_map_list(N, fn i => N-i))
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-list_grouping.sml] *)
