fun numDivisors (num: int) (divisor:int) (numDiv:int): int =
    if divisor = 1 then (numDivisors num (divisor+1) (numDiv+1))
        else if divisor = num then numDiv+1
        else if num mod divisor = 0 then (numDivisors num (divisor+1) (numDiv+1))
        else (numDivisors num (divisor+1) (numDiv))


fun isPrime(n0: int): bool =
    if n0 = 0 then false
        else if n0 = 1 then false
	else if (numDivisors n0 1 0) > 2 then false 
	else true