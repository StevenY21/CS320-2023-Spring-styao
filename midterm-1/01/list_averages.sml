(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
int2real
coerces an int into a real:
*)
val int2real = Real.fromInt
(* ****** ****** *)
(*
HX-2023-03-01: midterm1-01: 10 points
*)
(* ****** ****** *)
(*
Given a list of reals xs, list_averages(xs)
returns another list ys of reals such that:
ys[0] = xs[0] / 1.0
ys[1] = (xs[0] + xs[1]) / 2.0
ys[2] = (xs[0] + xs[1] + xs[2]) / 3.0
In general, ys[i] is the average of the first
(i+1) elements in xs.
//
For instance,
list_averages([]) = []
list_averages([1.0,2.0,3.0]) = [1.0,1.5,2.0]
list_averages([1.0,2.0,3.0,4.0]) = [1.0,1.5,2.0,2.5]
//
Note that you are allowed to define recursive
functions in your implementation of list_averages.
//
*)
(* ****** ****** *)
(*
fun
list_averages(xs: real list): real list = ...
*)
(* ****** ****** *)
fun list_sub(index: int, xs: real list): real = 
  case xs of
    nil => raise ListSubscript320
    | x1::xs => if index = 0 then x1 else list_sub(index-1,xs)

fun list_avg(index: int, xs: real list, sum: real, count: int): real = 
  if index < 0 then sum/int2real(count)
  else list_avg(index-1, xs, sum+list_sub(index, xs), count+1)

fun list_averages(xs: real list): real list =
    let
      fun findys(index: int, xs: real list, ys: real list ): real list = 
        if index = 0 then findys(index+1, xs, list_append(ys, [list_sub(0,xs)/int2real(index+1)]))
        else if index = list_length(xs) then ys
        else findys(index+1, xs, list_append(ys, [list_avg(index, xs, 0.0, 0)]))
    in
      if list_length(xs) = 0 then []
      else if list_length(xs) = 1 then xs
      else findys(0, xs, [])
    end
(* end of [CS320-2023-Spring-midterm1-list_averages.sml] *)