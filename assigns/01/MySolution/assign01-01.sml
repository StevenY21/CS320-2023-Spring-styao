use "./../assign01.sml";

fun xlist_size(xs: 'a xlist): int = 
	case xs of
		xlist_nil => 0 
		| xlist_cons(x1, xs) => 1 + xlist_size(xs)
		| xlist_snoc(xs, x1) => 1 + xlist_size(xs)
		| xlist_reverse(xs) => 0 + xlist_size(xs)
		| xlist_append(xs, ys) => xlist_size(xs) + xlist_size(ys)

