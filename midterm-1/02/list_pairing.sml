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
(*

*)

fun half_list(xs: 'a list, ys: 'a list, mid: int, count: int): 'a list= 
    case xs of
        nil => nil
        | x1::xs => if count = mid then ys else half_list(xs, list_append(ys, [x1]), mid, count+1)

fun list_pairing(xs: 'a list): ('a * 'a) list * 'a option =
    let
        val list_len = list_length(xs)
        val mid = list_len div 2
        val half_list1 = half_list(xs, [], mid, 0)
        val half_list2 = half_list(list_reverse(xs), [], mid, 0)
    in 
        if list_len = 0 then ([], NONE)
        else if list_len = 1 then ([], SOME(list_get_at(xs,0)))
        else
            if list_len mod 2 = 1 then (list_zip2(half_list1, half_list2),  SOME(list_get_at(xs,mid)))
            else (list_zip2(half_list1, half_list2), NONE)
    end
(* end of [CS320-2023-Spring-midterm1-list_pairing.sml] *)

