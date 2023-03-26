(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
HX-2023-03-24: 10 points
The following is a well-known series:
ln 2 = 1 - 1/2 + 1/3 - 1/4 + ...
Please implement a stream consisting of all the partial
sums of this series.
The 1st item in the stream equals 1
The 2nd item in the stream equals 1 - 1/2
The 3rd item in the stream equals 1 - 1/2 + 1/3
The 4th item in the stream equals 1 - 1/2 + 1/3 - 1/4
And so on, and so forth
//
*)

(* ****** ****** *)

(*
val the_ln2_stream: real stream = fn() => ...
*)

(* ****** ****** *)
fun is_even(n0: real, n1: int): bool = 
    if n0 > 0.0 then
        is_even(n0-1.0, n1 + 1)
    else
        if n1 mod 2 = 0 then true
        else false
fun part_sum_series(n: real): real =
    if n < 1.0 then 0.0
    else if is_even(n, 0) then 1.0/(~1.0*n) + part_sum_series(n-1.0)
    else 1.0/n + part_sum_series(n-1.0)
fun stream_from_ln(n: real): real stream = 
    fn () => strcon_cons(part_sum_series(n), stream_from_ln((n+1.0))) 
val the_ln2_stream = fn() => stream_from_ln(1.0)
(* end of [CS320-2023-Spring-assign06-01.sml] *)
