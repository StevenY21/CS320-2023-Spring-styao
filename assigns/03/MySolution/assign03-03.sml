(* ****** ****** *)
(*
use "./../assign03.sml";
use "./../assign03-lib.sml";
*)
(* ****** ****** *)

(*
//
HX-2023-02-10: 10 points
The function list_tabulate takes an integer
[n] and a function [f] and returns a list that
equals [f(0), f(1), ..., f(n-1)]
//
list_tabulate(n: int, f: int -> 'a): 'a list
//
*)
fun list_tabulate(n: int, f: int-> 'a): 'a list = 
	let
		fun loop( f: int -> 'a, start: int, finish: int): 'a list = 
			if start = finish then [] 
			else f(start) :: loop(f, start+1, finish)
	in
		loop(f, 0, n)
	end
			

(* ****** ****** *)

(* end of [CS320-2023-Spring-assign03-03.sml] *)
