use "./../assign01.sml";
use "./../MySolution/assign01-01.sml";

fun xlist_sub(xs: 'a xlist, i0: int): 'a =
	if i0 > (xlist_size(xs)-1) then raise XlistSubscript
	else
		case xs of
			xlist_nil => raise XlistSubscript
			| xlist_cons(x1, xs) => 
				if i0 > 0 then xlist_sub(xs, i0-1) else x1
			| xlist_snoc(xs, x1) => 
				if i0 = (xlist_size(xs)) then x1 else 
					if i0 < (xlist_size(xs)) then xlist_sub(xs, i0)
					else raise XlistSubscript
			| xlist_append(xs, ys) => 
				if i0 > (xlist_size(xs)-1) then xlist_sub(ys,i0-xlist_size(xs)) else 
					if i0 < (xlist_size(xs)-1) then xlist_sub(xs, i0) 
					else raise XlistSubscript
			| xlist_reverse(xs) =>  
				xlist_sub(xs, xlist_size(xs)-i0-1)
	
