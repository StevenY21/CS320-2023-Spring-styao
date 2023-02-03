(* ****** ****** *)

(*
These are the only library functions
that are allowed for completing Assign00
*)

(* ****** ****** *)

(*
All the arithmetic operations
All the primitive comparison operations
*)

(*
Note that div is for integer division
Note that mod is for integer modulo operation
Note that both div and mod are infix operators

val q = 10 div 3 (* q = 3 *)
val r = 10 mod 3 (* r = 1 *)
*)

(* ****** ****** *)

val ord = Char.ord (* char to ascii *)
val chr = Char.chr (* ascii to char *)

(* ****** ****** *)

val str = String.str (* char to string *)

(* ****** ****** *)

val strlen =
String.size (* string length *)

val strcat = op^ (* string concatenation *)
val strsub = String.sub (* string subcripting *)

(* ****** ****** *)

(* end of [CS320-2023-Spring-assign00-lib.sml] *)

(* ****** ****** *)
(* these are functions from my submitted work in assign00-04 *)
fun decimalPlace(len: int): int = 
    if len = 1 then 10 else 10 * decimalPlace(len-1)
fun leftoverStr(s1: string) (len: int) (pos: int): string = 
    if pos = len-1 then str(strsub(s1, pos))
        else if pos = 0 then  (leftoverStr (s1) (len) (pos + 1))
        else strcat(str(strsub(s1,pos)), (leftoverStr (s1) (len) (pos + 1)))
fun str2int(cs2: string): int = 
    if strlen(cs2) = 1 then (ord(strsub(cs2, 0)) - ord(#"0")) 
        else (ord(strsub(cs2, 0)) - ord(#"0")) * decimalPlace(strlen(cs2) - 1) + str2int(leftoverStr (cs2) (strlen(cs2)) (0))
(* ****** ****** *)

fun isLegal(cs3: string): int = 
	if strlen(cs3) = 1 then
		if (ord(strsub(cs3, 0)) - ord(#"0")) < 0 then 0
		else if (ord(strsub(cs3, 0)) - ord(#"0")) > 9 then 0
		else 1
	else if (ord(strsub(cs3, 0)) - ord(#"0")) < 0 then 0
	else if (ord(strsub(cs3, 0)) - ord(#"0")) > 9 then 0
	else 1 * isLegal(leftoverStr (cs3) (strlen(cs3)) (0))


fun str2int_opt(cs: string): int option = 
	if strlen(cs) = 0 then NONE
	else if strlen(cs) = 1 then
		if (ord(strsub(cs, 0)) - ord(#"0")) < 0 then NONE
		else if (ord(strsub(cs, 0)) - ord(#"0")) > 9 then NONE
		else SOME (ord(strsub(cs, 0)) - ord(#"0"))
	else if isLegal(cs) = 0 then NONE else SOME (str2int(cs))



