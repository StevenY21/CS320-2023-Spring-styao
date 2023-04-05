(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
HX-2023-03-31: 10 points
Please implement the following function
that turns a list of streams into stream of
lists.
//
fun
stream_ziplst('a stream list): 'a list stream
//
If we use a list of streams to represent a
list of rows of a matrix, then the returned
stream consist of lists that are columns of the
matrix.
*)

(* ****** ****** *)
fun next_stream_list(xss: 'a stream list): 'a stream list = 
    case xss of 
        nil => nil
        | x1 :: xss2 =>
            case x1() of 
            strcon_nil => []
            | strcon_cons(x2, fxs) => fxs::next_stream_list(xss2)
fun get_col(xss: 'a stream list): 'a list = 
    case xss of 
        nil => nil
        | x1 :: xss2 =>
            case x1() of
            strcon_nil => []
            | strcon_cons(x2, fxs) => x2::get_col(xss2)

fun stream_ziplst(xss: 'a stream list): 'a list stream = 
    let 
        val col = get_col(xss)
        val next_xss = next_stream_list(xss)
    in  
        if list_length(xss) <> list_length(next_xss) then stream_nil()
        else fn () => strcon_cons(col, stream_ziplst(next_xss))
    end


(* end of [CS320-2023-Spring-assign07-01.sml] *)
