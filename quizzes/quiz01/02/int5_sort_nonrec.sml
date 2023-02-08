(* ****** ****** *)
(*
HX-2023-02-07: 50 points
*)
(* ****** ****** *)

type int2 = int * int
type int3 = int * int * int
type int4 = int * int * int * int
type int5 = int * int * int * int * int

(* ****** ****** *)

(*
The following function int5_sort
is based on ListMergeSort.sort, which is
defined recursively. Given a tuple of 5
integers, int5_sort returns an ordered tuple
of the same 5 integers. For instance,
int5_sort(1, 2, 1, 2, 2) = (1, 1, 2, 2, 2)
int5_sort(3, 1, 2, 5, 2) = (1, 2, 2, 3, 5)
int5_sort(3, 1, 2, 5, 4) = (1, 2, 3, 4, 5)
*)

(*
val
int5_sort =
fn(xs: int5): int5 =
let
val (x1, x2, x3, x4, x5) = xs
val ys =
ListMergeSort.sort(op>=)[x1,x2,x3,x4,x5]
val y1 = hd(ys) and ys = tl(ys)
val y2 = hd(ys) and ys = tl(ys)
val y3 = hd(ys) and ys = tl(ys)
val y4 = hd(ys) and ys = tl(ys)
val y5 = hd(ys) and ys = tl(ys)
in
  (y1, y2, y3, y4, y5)
end
*)

(* ****** ****** *)
(*
Please give a non-recursive implementation of int5_sort
as int5_sort_nr. That is, please implement int5_sort_nr
in a non-recursive manner such that int5_sort(xs) equals
int5_sort_nr(xs) for every 5-tuple xs of the type int5.
*)
(* ****** ****** *)

fun int2_sort(xs: int2): int2 = 
	if #1(xs) > #2(xs) then (#2(xs), #1(xs)) else (#1(xs), #2(xs))
fun int3_sort(xs: int3): int3 =
	let
		val ys = int2_sort((#1(xs), #2(xs)))
	in
		if #3(xs) > #2(ys) then (#1(ys), #2(ys), #3(xs))
		else if #3(xs) > #1(ys) then (#1(ys), #3(xs), #2(ys))
		else (#3(xs), #1(ys), #2(ys))
	end
fun int4_sort(xs: int4): int4 = 
	let
		val ys = int3_sort((#1(xs), #2(xs), #3(xs)))
	in 
		if #4(xs) > #3(ys) then (#1(ys), #2(ys), #3(ys), #4(xs))
		else if #4(xs) > #2(ys) then (#1(ys), #2(ys), #4(xs), #3(ys))
		else if #4(xs) > #1(ys) then (#1(ys), #4(xs), #2(ys), #3(ys))
		else (#4(xs), #1(ys), #2(ys), #3(ys))
	end
fun int5_sort_nr(xs: int5): int5 =
	let
		val ys = int4_sort((#1(xs), #2(xs), #3(xs), #4(xs)))
	in
		if #5(xs) >= #4(ys) then (#1(ys), #2(ys), #3(ys), #4(ys), #5(xs))
		else if #5(xs) >= #3(ys) then (#1(ys), #2(ys), #3(ys), #5(xs), #4(ys))
		else if #5(xs) >= #2(ys) then (#1(ys), #2(ys), #5(xs), #4(ys), #3(ys))
		else if #5(xs) >= #1(ys) then (#1(ys), #5(xs), #2(ys), #3(ys), #4(ys))
		else (#5(xs), #1(ys), #2(ys), #3(ys), #4(ys))
	end

(* ****** ****** *)

(* end of [CS320-2023-Spring-quiz01-int5_sort_nonrec.sml] *)
