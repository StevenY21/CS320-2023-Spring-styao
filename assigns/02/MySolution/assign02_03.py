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
        elif mylist_consq(xs) == True:
            x1 = xs.get_cons1()
            xs = xs.get_cons2()
            if mylist_nilq(xs) == True:
                return (mylist_cons(x1, mylist_nil()), mylist_nil())
            elif mylist_consq(xs) == True:
                x2 = xs.get_cons1()
                xs = xs.get_cons2()
                (ys, zs) = split(xs)
                return (mylist_cons(x1, ys), mylist_cons(x2, zs))
    def merge(ys, zs):
        if mylist_nilq(ys) == True:
            return zs
        elif mylist_consq(ys) == True:
            y1 = ys.get_cons1()
            ys = ys.get_cons2()
            if mylist_nilq(zs) == True:
                return mylist_cons(y1, ys)
            elif mylist_consq(zs) == True:
                z1 = zs.get_cons1()
                zs = zs.get_cons2()
                if y1 <= z1:
                    return mylist_cons(y1, merge(ys, mylist_cons(z1, zs)))
                else:
                    return mylist_cons(z1, merge(mylist_cons(y1, ys), zs))
    if mylist_nilq(xs) == True:
        return mylist_nil()
    elif mylist_consq(xs) == True:
        x1 = xs.get_cons1()
        xs = xs.get_cons2()
        if mylist_nilq(xs) == True:
            return mylist_cons(x1, mylist_nil())
        elif mylist_consq(xs) == True:
            x2 = xs.get_cons1()
            xs = xs.get_cons2()
            (ys, zs) = split(xs)
            return merge(mylist_mergesort(mylist_cons(x1, ys)), mylist_mergesort(mylist_cons(x2, zs)))
