(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
HX-2023-04-07: 20 points
Given a list xs, stream_permute_list(xs) returns
a stream of ALL the permutations of xs.
For instance, if xs = [1,2,3], then the returned
stream should enumerate the following 6 lists:
[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2] and [3,2,1]
//
fun
stream_permute_list(xs: 'a list): 'a list stream = ...
//
*)
fun stream_interleave(x: 'a, xs: 'a list): 'a list stream = fn() =>
    case xs of
        nil => strcon_cons([x], fn() => strcon_nil)
        | x1:: xs1 => 
            strcon_cons(x::x1::xs1, stream_make_map(stream_interleave(x, xs1), (fn(l) => x1:: l)))
fun stream_permute_list(xs: 'a list): 'a list stream = fn() =>
    case xs of 
        nil => strcon_cons([], stream_nil())
        | x1::xs1 =>
            stream_concat(stream_make_map(stream_permute_list(xs1), fn(xs) => stream_interleave(x1, xs)))()
(* ****** ****** *)

(* end of [CS320-2023-Spring-assign08-01.sml] *)
