(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
HX-2023-03-24: 10 points
Please enumerate all the pairs of natural
numbers. Given pairs (i1, j1) and (i2, j2),
(i1, j1) should be enumerated ahead of (i2, j2)
if i1+j1 < i2+j2.
*)

(* ****** ****** *)

(*
val theNatPairs: (int*int) stream = fn () => ...
*)

(* ****** ****** *)
(* (0, 0), (0, 1), (1, 0), (0, 2), (1, 1), (2, 0), (0, 3), (1, 2), (2, 1), (3, 0), (0, 4), (1, 3), (2, 2), (3, 1), (4, 0), ...*)
fun next_pair(i1:int, j1:int, k1:int): (int*int*int) = 
    if (i1,j1) = (k1,0) then (0, k1+1, k1+1)
    else (i1+1, j1-1, k1)
fun pairs_from(i:int, j:int, k:int): (int*int) stream =
    let 
        val pair_next = next_pair(i, j, k)
        val next_i = #1(pair_next)
        val next_j = #2(pair_next)
        val next_k = #3(pair_next)
    in 
        fn () => strcon_cons((i, j), pairs_from(next_i, next_j, next_k))
    end

val theNatPairs: (int*int) stream = fn () => pairs_from(0, 0, 0)()
(* end of [CS320-2023-Spring-assign06-02.sml] *)
