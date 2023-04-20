(* ****** ****** *)

use "./../../mysmlib/mysmlib-cls.sml";

(* ****** ****** *)

(*
//
// HX-2023-04-20: 20 points
//
Given a stream fxs of real numbers a0, a1, a2, ...
and a real number x0, stream_evaluate(fxs, x0)
returns another stream of real number that enumerates
all of the following partial sums:
a0, a0 + a1*x0, a0 + a1*x0 + a2*x0^2, ...
The general form of the enumerated sums is given as follows:
(a0 + a1*x0 + a2*x0^2 + ... + an * x0^n)
//
Assume:
a0 = 0, a1 = 1, a2 = -1/2, a3 = 1/3, a4 = -1/4, ...
Then we have ln2 = stream_evaluate(fxs, 1.0) // see Assign06-01
//
*)

(* ****** ****** *)

(*
fun
stream_evaluate
(fxs: real stream, x0: real): real stream = ...
*)
fun power(x0:real, n:int): real = 
    if n = 1 then x0 
    else x0 * power(x0, n-1)
fun eval_stream (fxs: real stream, x0: real, prev: real, n: real, n1: int): real stream = fn() =>
    case fxs() of
        strcon_nil => strcon_nil
        | strcon_cons(x1, fxs) =>
            if n1 = 0 then
                strcon_cons(x1, eval_stream(fxs, x0, x1, n+1.0, n1+1))
            else
                let  
                    val pow_x0 = Math.pow(x0, n)
                    val sum_x1 = prev + x1*pow_x0
                in
                    strcon_cons(sum_x1, eval_stream(fxs, x0, sum_x1, n+1.0, n1+1))
                end
fun stream_evaluate (fxs: real stream, x0: real): real stream = eval_stream(fxs, x0, x0, 0.0, 0)
    
(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm2-01.sml] *)
