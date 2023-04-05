(* ****** ****** *)
use "./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
Please put your implementation here for quiz04-02
*)

(* ****** ****** *)
fun unique_ints(fxs: int stream, dupe_list: int list): int list = 
    case fxs() of
        strcon_nil => []
        | strcon_cons(x1, fxs) =>
            if list_forall(dupe_list, fn(x2) => x2 <> x1) then x1::unique_ints(fxs, x1::dupe_list)
            else unique_ints(fxs, dupe_list)


fun stream_dupremov(fxs: int stream) = list_streamize(unique_ints(fxs, []))
(* end of [CS320-2023-Spring-quizzes-quiz04-02.sml] *)