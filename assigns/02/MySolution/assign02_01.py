####################################################
import sys
sys.path.append('..')
from assign02 import *
####################################################
print("[import ./../assign02.py] is done!")
####################################################
#
# Please implement (20 points)
# mylist_append (see list_append in assign02.sml)
# mylist_rappend (see list_rappend in assign02.sml)
# mylist_reverse (see list_reverse in assign02.sml)
#
####################################################
def mylist_append(xs, ys):
    if mylist_nilq(xs) == True:
        return ys
    elif mylist_consq(xs) == True:
        x1 = xs.get_cons1()
        xs = xs.get_cons2()
        return mylist_cons(x1, mylist_append(xs, ys))

def mylist_rappend(xs, ys):
    if mylist_nilq(xs) == True:
        return ys
    elif mylist_consq(xs) == True:
        x1 = xs.get_cons1()
        xs = xs.get_cons2()
        return mylist_rappend(xs, mylist_cons(x1, ys))

def mylist_reverse(xs):
    return mylist_rappend(xs, mylist_nil())
    