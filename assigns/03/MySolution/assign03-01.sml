(* ****** ****** *)
(*
use "./../assign03.sml";
use "./../assign03-lib.sml";
*)
(* ****** ****** *)

(*
//
HX-2023-02-09: 10 points
//
The function find_root(f0)
finds the first root of [f0] in
the following sequence:
0, 1, -1, 2, -2, 3, -3, 4, -4, ...
*)
(*
fun 
find_root(f0: int -> int): int = ...
*)
fun find_root(f0: int -> int): int =
	let 
		exception ZERO of int
		fun loop(i: int): int = 
			if f0(i) <> 0 then 
				if i > 0 then loop(~1 * i)
				else loop((~1 * i) + 1)
			else raise ZERO(i) 
	in
		loop(0) handle ZERO(i) => i
	end
(* ****** ****** *)

(* end of [CS320-2023-Spring-assign03-01.sml] *)