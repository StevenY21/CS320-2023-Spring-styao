use "./../assign00-lib.sml";

fun int2str(i0: int): string = 
    if (i0 div 10) = 0 then str(chr(ord(#"0") + (i0))) 
        else strcat((int2str(i0 div 10)), str(chr(ord(#"0") + (i0 mod 10))))