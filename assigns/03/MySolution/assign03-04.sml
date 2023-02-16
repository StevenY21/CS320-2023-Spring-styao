(* ****** ****** *)
(*
use "./../assign03.sml";
use "./../assign03-lib.sml";
*)
(* ****** ****** *)

(*
HX-2023-02-10: 20 points
Given a list of integers xs,
please implement a function that find
the longest ascending subsequences of [xs].
If there are more than one such sequences,
the left most one should be returned.
fun list_longest_ascend(xs: int list): int list
*)
use "./../../../mysmlib/mysmlib-cls.sml";
	
fun list_sub(xs: int list, pos: int): int = 
	if pos > (list_length(xs)-1) then raise ListSubscript320
	else
		case xs of
			[] => 0
			| x1::xs => if pos = 0 then x1 else list_sub(xs, pos-1)

fun longer_list(xs: int list, ys: int list, zs: int list): int list = 
	let
		fun longer(xs: int list, ys: int list): int list =
			case xs of
				[] => ys
				| x1::xs => 
					if list_sub(ys, list_length(ys)-1) <= x1 then longer(xs, list_append(ys, [x1]))
					else longer(xs, ys)
	in
		if list_length(ys) >= list_length(longer(xs, zs)) then ys
		else longer(xs,zs)
	end				
	
fun longer_equals_list(xs: int list, ys: int list, zs: int list): int list = 
	let
		fun longer(xs: int list, ys: int list): int list =
			case xs of
				[] => ys
				| x1::xs => 
					if list_sub(ys, list_length(ys)-1) = x1 then longer(xs, list_append(ys, [x1]))
					else longer(xs, ys)
	in
		if list_length(ys) >= list_length(longer(xs, zs)) then ys
		else longer(xs,zs)
	end	

fun list_longest_ascend(xs: int list): int list = 
	let
		(* ys and zs are there to compare sub lists *)
		(* ys is always the earlier sublist created within the list *)
		fun longest_list(xs: int list, ys: int list): int list = 
			case xs of
				[] => ys
				| x1::xs => 
					if list_length(longer_list(xs, ys, [x1])) > list_length(longer_equals_list(xs, ys, [x1])) then longest_list(xs, longer_list(xs, ys, [x1]))
					else longest_list(xs, longer_equals_list(xs, ys, [x1]))
		fun first_seq(xs: int list, ys: int list, zs: int list): int list =
			case xs of
				[] => ys
				| x1::xs => 
					if list_length(xs)+1 = list_length(zs) then first_seq(xs, ys, zs)
					else if list_sub(ys, list_length(ys)-1) <= x1 then first_seq(xs, list_append(ys, [x1]),zs)
					else first_seq(xs, ys, zs)			
	in
		if xs = [] then []
		else if list_length(xs) = 1 then xs
		else longest_list(xs, first_seq(xs, [list_sub(xs, 0)], xs))
	end
	
						
(* ****** ****** *)

(* end of [CS320-2023-Spring-assign03-04.sml] *)
