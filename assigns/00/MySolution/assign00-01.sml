fun fact(x: int): int =
	if x > 0 then x * fact(x-1) else 1

fun fact2(x: int): int = 
	if (fact(x) handle Overflow => 0) = 0 then x else fact2(x+1)

val N = fact2 0