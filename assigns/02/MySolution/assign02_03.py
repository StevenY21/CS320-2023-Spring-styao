####################################################
import sys
sys.path.append('..')
from assign02 import *
####################################################
print("[import ./../assign02.py] is done!")
####################################################
#
# Please implement (20 points)
# mylist_mergesort (see list_mergesort in assign02.sml)
#
####################################################
def mylist_mergesort(xs):
    def split(xs):
        if mylist_nilq(xs) == True:
            return (mylist_nil(), mylist_nil())
        else:
            if mylist_nilq(xs.cons2) == True:
                return (mylist_cons(xs.cons1, mylist_nil()), mylist_nil())
            else:
                yszs = split(xs.cons2.cons2)
                ys = yszs[0]
                zs = yszs[1]
                return (mylist_cons(xs.cons1, ys), mylist_cons(xs.cons2.cons1, zs))
    def merge(ys, zs):
        if mylist_nilq(ys) == True:
            return zs
        else:
            if mylist_nilq(zs) == True:
                return mylist_cons(ys.cons1, ys.cons2)
            else:
                if ys.cons1 <= zs.cons1:
                    return mylist_cons(ys.cons1, merge(ys.cons2, mylist_cons(zs.cons1, zs.cons2)))
                else:
                    return mylist_cons(zs.cons1, merge(mylist_cons(ys.cons1, ys.cons2), zs.cons2))
    if mylist_nilq(xs) == True:
        return mylist_nil()
    else:
        if mylist_nilq(xs.cons2) == True:
            return mylist_cons(xs.cons1, mylist_nil())
        else:
            yszs = split(xs.cons2.cons2)
            ys = yszs[0]
            zs = yszs[1]
            return merge(mylist_mergesort(mylist_cons(xs.cons1, ys)), mylist_mergesort(mylist_cons(xs.cons2.cons1, zs)))
