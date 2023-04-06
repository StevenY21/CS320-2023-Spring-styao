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


fun bigger_csum(ij1:(int * int), ij2:(int * int)): bool = 
    let
        val csum1 = (#1(ij1)*(#1(ij1))*(#1(ij1))) + (#2(ij1)*(#2(ij1))*(#2(ij1)))
        val csum2 = (#1(ij2)*(#1(ij2))*(#1(ij2))) + (#2(ij2)*(#2(ij2))*(#2(ij2)))
    in 
        csum1 <= csum2
    end
fun nj_stream(i0:int, j0: int): (int * int) stream = fn() => strcon_cons((i0, j0), nj_stream(i0, j0+1))
fun sort_NatPairs(i0: int, sorted_stream:(int * int) stream): (int * int) stream = 
    let 
        val n_stream = nj_stream(i0, i0)
        val fxs = stream_merge2(sorted_stream, n_stream, fn(x1, x2) => bigger_csum(x1, x2))
    in
      fn() => strcon_cons(stream_head(fxs), sort_NatPairs(i0+1, stream_tail(fxs)))
      (*sort_NatPairs(i0+1, fxs)*)
    end
val theNatPairs_cubesum: (int * int) stream = fn() => sort_NatPairs(1, nj_stream(0,0))()

(* end of [CS320-2023-Spring-assign07-02.sml] *)
