####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../../mypylib')
from mypylib_cls import *
####################################################
#
# HX-2023-03-14: 20 points
# Please *translate* into Python the posted solution
# on Piazza for word_neighbors (which is writtend in SML)
#
def strsub(word, pos):
    return word[pos]
def string_length(word):
    return string_foldleft(word, 0, (lambda res, wrd: res + 1))
def string_implode(clist):
    return fnlist_foldright(clist, "", lambda acc, ch: ch + acc)
def string_tabulate(strlen, fopr):
    def fnlist_tabulate(strlen, fopr):
        return fnlist_reverse(int1_foldright(strlen, fnlist_nil(), lambda x, res: fnlist_cons(fopr(x), res)))
    return string_implode(fnlist_tabulate(strlen, fopr))
AB = "abcdefghijklmnopqrstuvwxyz"

def word_neighbors(word):
    strlen = string_length(word)
    return fnlist_concat(
            string_imap_fnlist(word, (lambda i, c: 
                fnlist_concat(
                    string_imap_fnlist(AB, (lambda _, c2:
                        fnlist_sing(string_tabulate(strlen, (lambda j: strsub(word,j) if i != j else c2))) if c!=c2 else fnlist_nil()
                    )
                    )
                )
            )
            )
        )
    """
    Note that this function should returns a fnlist
    (not a pylist)
    Your implementation should be combinator-based very
    much like the posted solution.
    """
#
####################################################