(* ****** ****** *)
use "./third-order.sml";
(* ****** ****** *)

datatype 'a xlist =
xlist_nil
|
xlist_cons of ('a * 'a xlist)
|
xlist_snoc of ('a xlist * 'a)
|
xlist_append of ('a xlist * 'a xlist)
|
xlist_reverse of ('a xlist)

(* ****** ****** *)

fun
xlist_foreach
(xs: 'a xlist, work: 'a -> unit): unit =
(
case xs of
  xlist_nil => ()
| xlist_cons(x1, xs) =>
  (work(x1); xlist_foreach(xs, work))
| xlist_snoc(xs, x1) =>
  (xlist_foreach(xs, work); work(x1))
| xlist_append(ys, zs) =>
  (xlist_foreach(ys, work);
   xlist_foreach(zs, work))
| xlist_reverse(ys) => xlist_rforeach(ys, work)
)

and
xlist_rforeach
(xs: 'a xlist, work: 'a -> unit): unit =
case xs of
  xlist_nil => ()
| xlist_cons(x1, xs) =>
  (xlist_rforeach(xs, work); work(x1))
| xlist_snoc(xs, x1) =>
  (work(x1); xlist_rforeach(xs, work))
| xlist_append(ys, zs) =>
  (xlist_rforeach(zs, work);
   xlist_rforeach(ys, work))
| xlist_reverse(ys) => xlist_foreach(ys, work)

(* ****** ****** *)

val xlist_forall =
fn(xs,test) =>
foreach_to_forall(xlist_foreach)(xs,test)

(* ****** ****** *)

val xlist_length =
fn(xs) => foreach_to_length(xlist_foreach)(xs)

(* ****** ****** *)

val xlist_listize =
fn(xs) => foreach_to_listize(xlist_foreach)(xs)
val xlist_rlistize =
fn(xs) => foreach_to_listize(xlist_rforeach)(xs)

(* ****** ****** *)

val xlist_foldleft =
fn(r0,xs,fopr) =>
  foreach_to_foldleft(xlist_foreach)(r0,xs,fopr)

(* ****** ****** *)
(*
val xlist_foldright
fn(r0,xs,fopr) =>
  rforeach_to_foldright(xlist_rforeach)(r0,xs,fopr)
*)
(* ****** ****** *)

val xs = xlist_nil
val xs = xlist_cons(1, xs)
val xs = xlist_cons(2, xs)
val xs = xlist_snoc(xs, 3)
val xs = xlist_snoc(xs, 4)
val xs = xlist_reverse(xs)
val xs = xlist_append(xs, xs)
val xs_list = xlist_listize(xs)
val xs_rlist = xlist_rlistize(xs)

(* ****** ****** *)

val len0 = xlist_length(xs)
val all1 = xlist_forall(xs, fn(x:int) => x < 5)
val all2 = xlist_forall(xs, fn(x:int) => x > 2)

(* ****** ****** *)

(* end of [CS320-2023-Spring-lectures-xlist.sml] *)
