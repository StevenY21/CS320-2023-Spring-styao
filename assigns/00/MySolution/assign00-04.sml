use "./../assign00-lib.sml";

fun decimalPlace(len: int): int = 
    if len = 1 then 10 else 10 * decimalPlace(len-1)

fun leftoverStr(s1: string) (len: int) (pos: int): string = 
    if pos = len-1 then str(strsub(s1, pos))
        else if pos = 0 then  (leftoverStr (s1) (len) (pos + 1))
        else strcat(str(strsub(s1,pos)), (leftoverStr (s1) (len) (pos + 1)))

fun str2int(cs: string): int = 
    if strlen(cs) = 1 then (ord(strsub(cs, 0)) - ord(#"0")) 
        else (ord(strsub(cs, 0)) - ord(#"0")) * decimalPlace(strlen(cs) - 1) + str2int(leftoverStr (cs) (strlen(cs)) (0))

