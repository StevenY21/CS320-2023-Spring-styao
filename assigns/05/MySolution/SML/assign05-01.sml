(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
HX-2023-03-14: 20 points
Recall that a reference is precisely an array
of size 1. And it can be treated as a sequence.
For instance, we can define ref_foreach as follows
*)

(* ****** ****** *)

fun ref_foreach (r0: 'a ref, work: 'a -> unit): unit = work(!r0)

(* ****** ****** *)

(*
Please implement directly the following combinators
for for references. That is, your implementation should
not make use of any third-order functions defined in the
library for this class.
*)

(* ****** ****** *)
fun ref_get_at (r0: 'a ref, i: int): 'a = 
    if i > 0 then raise Subscript 
    else if i < 0 then raise Subscript
    else !r0
fun ref_forall (r0: 'a ref, test: 'a -> bool): bool = test(!r0)
fun ref_map_list (r0: 'a ref, fopr: ('a) -> 'b): 'b list = list_append([],[fopr(!r0)])
fun ref_foldleft (r0: 'a ref, res: 'r, fopr: ('r * 'a) -> 'r): 'r = fopr(res, !r0)
fun ref_ifoldleft (r0: 'a ref, res: 'r, fopr: ('r * int * 'a) -> 'r): 'r = fopr(res, 0, !r0)
(*
fun
ref_get_at
(ref: 'a ref, i: int): 'a
fun
ref_forall
(ref: 'a ref, test: 'a -> bool): bool
fun
ref_map_list
(ref: 'a ref, fopr: ('a) -> 'b): 'b list
fun
ref_foldleft
(ref: 'a ref, res: 'r, fopr: ('r * 'a) -> 'r): 'r
fun
ref_ifoldleft
(ref: 'a ref, res: 'r, fopr: ('r * int * 'a) -> 'r): 'r
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-assign05-01.sml] *)
