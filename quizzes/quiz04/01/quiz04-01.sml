(* ****** ****** *)
use "./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
Please put your implementation here for quiz04-01
*)

(* ****** ****** *)
val theAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
val abc_size = string_foldleft(theAlphabet, 0, fn(r0, i0) => r0 +1)
fun cycle_abc(the_abc: string, pos: int, abc_size: int): char stream = 
    let 
        val curr_abc = String.sub(theAlphabet, pos)
    in
        if pos = abc_size-1 then fn() => strcon_cons(curr_abc, cycle_abc(the_abc, 0, abc_size))
        else fn() => strcon_cons(curr_abc, cycle_abc(the_abc, pos+1, abc_size))
    end
fun alphabeta_cycling_list(): char stream = fn() => cycle_abc(theAlphabet, 0, abc_size)()
(* end of [CS320-2023-Spring-quizzes-quiz04-01.sml] *)