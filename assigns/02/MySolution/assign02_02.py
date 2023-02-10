####################################################
import sys
sys.path.append('..')
from assign02 import *
from assign02_01 import *
####################################################
print("[import ./../assign02.py] is done!")
####################################################
#
# Please implement (10 points)
# mylist_quicksort (see list_quicksort in assign02.sml)
#
####################################################
def mylist_quicksort(xs):
    def qsort(xs):
        if mylist_nilq(xs) == True:
            return mylist_nil()
        elif mylist_consq(xs) == True:
            yszs = qpart(xs.cons2, xs.cons1)
            ys = qsort(yszs[0])
            x1 = mylist_cons(xs.cons1, mylist_nil())
            zs = qsort(yszs[1])
            qsortlist = mylist_append(x1,zs)
            qsortlist = mylist_append(ys, qsortlist)
            return qsortlist
        
    def qpart(xs, p0):
        if mylist_nilq(xs) == True:
            return (mylist_nil(), mylist_nil())
        elif mylist_consq(xs) == True:
            yszs = qpart(xs.cons2, p0)
            ys = yszs[0]
            zs = yszs[1]
            if xs.cons1 <= p0:
                return (mylist_cons(xs.cons1, ys), zs)
            else:
                return (ys, mylist_cons(xs.cons1, zs))
    return qsort(xs)