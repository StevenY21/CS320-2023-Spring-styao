use "./../assign00-lib.sml";

fun leftoverStrRev(s1: string) (len: int) (pos: int): string = 
    if pos = len-2 then str(strsub(s1, pos))
        else strcat(str(strsub(s1,pos)), (leftoverStrRev (s1) (len) (pos + 1)))

fun stringrev(cs: string): string = 
    if strlen(cs) = 0 then cs 
	else if strlen(cs) = 1 then cs
        else strcat(str(strsub(cs, strlen(cs) - 1)), stringrev(leftoverStrRev (cs) (strlen(cs)) (0)))