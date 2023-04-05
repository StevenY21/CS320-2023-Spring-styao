(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
//
HX-2023-03-31: 20 points
Please implement the following function
that enumerates all the pairs (i, j) of natural
numbers satisfying $i <= j$; a pair (i1, j1) must
be enumerated ahead of another pair (i2, j2) if the
following condition holds:
  i1*i1*i1 + j1*j1*j1 < i2*i2*i2 + j2*j2*j2
//
val
theNatPairs_cubesum: (int * int) stream = fn () =>
//
*)

(* ****** ****** *)
(*(0,0), (1,0), (0,1), (1,1) *)

fun
stream_merge2
( fxs1: 'a stream
, fxs2: 'a stream
, lte3: 'a * 'a -> bool): 'a stream = fn() =>
(
case fxs1() of
  strcon_nil => fxs2()
| strcon_cons(x1, fxs1) =>
(
case fxs2() of
strcon_nil =>
strcon_cons(x1, fxs1)
|
strcon_cons(x2, fxs2) =>
if
lte3(x1, x2)
then strcon_cons
(x1, stream_merge2(fxs1, stream_cons(x2, fxs2), lte3))
else strcon_cons
(x2, stream_merge2(stream_cons(x1, fxs1), fxs2, lte3))
)
)
fun bigger_csum(ij1:(int * int), ij2:(int * int)): bool = 
    let
        val csum1 = (#1(ij1)*(#1(ij1))*(#1(ij1))) + (#2(ij1)*(#2(ij1))*(#2(ij1)))
        val csum2 = (#1(ij2)*(#1(ij2))*(#1(ij2))) + (#2(ij2)*(#2(ij2))*(#2(ij2)))
    in 
        csum1 <= csum2
    end

fun sort_NatPairs(i0: int, sorted_stream:(int * int) stream): (int * int) stream = 
    let 
        val n_stream = stream_make_filter(stream_tabulate(~1, fn(i1) => (i0, i1)), fn(x1) => #1(x1) <= #2(x1))
        val fxs = stream_merge2(sorted_stream, n_stream, fn(x1, x2) => bigger_csum(x1, x2))
    in
      case fxs() of
        strcon_nil => strcon_nil
        | strcon_cons(x1, fxs) => fn() => strcon_cons(x1, sort_NatPairs(i0, fxs))
    end

val theNatPairs_cubesum: (int * int) stream = fn() => sort_NatPairs(1, stream_tabulate(~1, fn(i0) => (0, i0)))()
(* end of [CS320-2023-Spring-assign07-02.sml] *)
