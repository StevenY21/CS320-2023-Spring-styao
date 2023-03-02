(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-01: midterm1-01: 10 points
*)
(* ****** ****** *)
(*
Given a list xs, list_pairing(xs) returns
a list of pairs and an option; the 1st pair
consists of the first and last elements in xs,
and the 2nd pair consists of the second and the
second last elements in xs, and so on and so forth;
and the option is NONE if |xs| is even, and it is
SOME(xm) if |xs| is odd and xm is the middle element
in xs.
//
For instance, we have:
//
list_pairing([]) = ([], NONE)
list_pairing([1]) = ([], SOME(1))
list_pairing([1,2]) = ([(1,2)], NONE)
list_pairing([1,2,3]) = ([(1,3)], SOME(2))
list_pairing([1,2,3,4]) = ([(1,4),(2,3)], NONE)
//
*)
(* ****** ****** *)
(*
fun
list_pairing
(xs: 'a list): ('a * 'a) list * 'a option = ...
*)
(* ****** ****** *)
fun list_sub(index: int, xs: 'a list): 'a = 
  case xs of
    nil => raise ListSubscript320
    | x1::xs => if index = 0 then x1 else list_sub(index-1,xs)

fun list_pairs(xs: 'a list, index: int, acc: ('a * 'a) list): ('a * 'a) list = 
    if list_length(xs) = 2 then [(list_sub(index, xs), list_sub(list_length(xs)-index-1, xs))]
    else
        if list_length(xs) mod 2 = 1 andalso ((index*2) + 1) = list_length(xs) then acc
        else if index = list_length(xs) then acc
        else list_pairs(xs, index+1, list_append(acc, [(list_sub(index, xs), list_sub(list_length(xs)-index-1, xs))]))

fun middle(xs: 'a list, index: int): 'a =
    if (index*2)+1 = list_length(xs) then list_sub(index,xs)
    else middle(xs, index+1)

fun list_pairing(xs: 'a list): ('a * 'a) list * 'a option =
    if list_length(xs) = 0 then ([], NONE)
    else if list_length(xs) = 1 then ([], SOME(list_sub(0, xs)))
    else
        if list_length(xs) mod 2 = 1 then (list_pairs(xs, 0, []), SOME(middle(xs, 0)))
        else (list_pairs(xs, 0, []), NONE)

(* end of [CS320-2023-Spring-midterm1-list_pairing.sml] *)
