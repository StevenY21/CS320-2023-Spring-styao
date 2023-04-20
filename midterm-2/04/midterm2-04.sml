(* ****** ****** *)

use "./../../mysmlib/mysmlib-cls.sml";

(* ****** ****** *)

(*
//
// HX-2023-04-20: 20 points
//
// A non-empty sequence of numbers forms a
// "drawdown" if every number in the sequence does not
// exceed the first one. A maximal drawdown is one that
// is not contained in any longer drawdowns.
// Please implement a function stream_drawdowns that takes
// an infinite stream fxs of integers and returns a stream
// enumerating all the maximal drawdowns in fxs.
//
*)

(* ****** ****** *)

(*
fun
stream_drawdowns(fxs: int stream): int list stream = ... *)
fun drawdowns(fxs: int stream, xs: int list, x2: int): int list stream = fn() =>
    case fxs() of
        strcon_nil => strcon_nil
        | strcon_cons(x1, fxs) => 
            if x1 <= x2 then drawdowns(fxs, list_append(xs, [x1]), x2)()
            else strcon_cons(xs, drawdowns(fxs, [x1], x1))
fun stream_drawdowns(fxs: int stream): int list stream = fn() =>
    case fxs() of
        strcon_nil => strcon_nil
        | strcon_cons(x1, fxs) => drawdowns(fxs, [x1], x1)()

(* ****** ****** *)


(* end of [CS320-2023-Spring-midterm2-04.sml] *)
