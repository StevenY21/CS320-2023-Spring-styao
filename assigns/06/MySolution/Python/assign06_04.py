####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../../mypylib')
from mypylib_cls import *

sys.path.append("./../../../05/Mysolution/Python")
from assign05_02 import *

sys.path.append("./../../")
from dictwords import*

import queue
####################################################
"""
HX-2023-03-24: 30 points
Solving the doublet puzzle
"""
####################################################
def word_neighbors_legal(word):
    return pylist_filter_pylist(word_neighbors(word), word_is_legal)

def wrdpath_neighbors_legal(wrdpath):
    word = wrdpath[-1]
    neighbor_words = word_neighbors_legal(word)
    neighbor_lst = [wrdpath + (wrd,) for wrd in neighbor_words]
    return neighbor_lst

def gtree_bfs(nxs, fchildren):
    def helper(nxs):
        if nxs.empty():
            return strcon_nil()
        else:
            nx1 = nxs.get()
            for nx2 in fchildren(nx1):
                nxs.put(nx2)
            return strcon_cons(nx1, gtree_bfs(nxs, fchildren))
    return lambda: helper(nxs)
def doublet_stream_from(word):
    """
Please revisit assign05_02.py.
######
Given a word w1 and another word w2, w1 and w2 are a
1-step doublet if w1 and w2 differ at exactly one position.
For instance, 'water' and 'later' are a 1-step doublet.
The doublet relation is the reflexive and transitive closure
of the 1-step doublet relation. In other words, w1 and w2 are
a doublet if w1 and w2 are the first and last of a sequence of
words where every two consecutive words form a 1-step doublet.
Here is a little website where you can use to check if two words
for a doublet or not:
http://ats-lang.github.io/EXAMPLE/BUCS320/Doublets/Doublets.html
######
Given a word, the function [doublet_stream_from] returns a stream
enumerating *all* the tuples such that the first element of the tuple
is the given word and every two consecutive words in the tuple form a
1-step doublet. The enumeration of tuples should be done so that shorter
tuples are always enumerated ahead of longer ones.
######
"""
    nxs = queue.Queue() 
    nxs.put((word,))
    return gtree_bfs(nxs, wrdpath_neighbors_legal)
####################################################
