####################################################
#!/usr/bin/env python3
####################################################
import sys
####################################################
sys.path.append('../../../07')
sys.path.append('./../../../../mypylib')
####################################################
from dictwords import *
from mypylib_cls import *
from assign05_02 import *
import queue
####################################################
"""
HX-2023-03-24: 10 points
Solving the doublet puzzle
"""
####################################################
"""
Please revisit assign06_04.py.
######
Given a word w1 and another word w2, w1 and w2 are a
1-step doublet if w1 and w2 differ at exactly one position.
For instance, 'water' and 'later' are a 1-step doublet.
The doublet relation is the reflexive and transitive closure
of the 1-step doublet relation. In other words, w1 and w2 are
a doublet if w1 and w2 are the first and last of a sequence of
words where every two consecutive words form a 1-step doublet.
<Here is a little website where you can use to check if two words
for a doublet or not:
http://ats-lang.github.io/EXAMPLE/BUCS320/Doublets/Doublets.html
######
"""
####################################################

def doublet_bfs_test(w1, w2):
    if len(w1) != len(w2): #if the words have diff len they cannot be doublets
        return None 
    elif not(word_is_legal(w1)) or not(word_is_legal(w2)):
        return None
    else:
        def diff_letters(res, pos): # determines if the letter at that position is different for both words
            if w1[pos] != w2[pos]:
                res += [(w2[pos], pos)]
            return res
        letter_lst = int1_foldleft(len(w1), [], diff_letters)
        # accumulates a list of all the differing letters and the positions
        def valid_doublet_path(wrd1): # takes a word and forms all the doublets from it
            if wrd1 == w2:
                return []
            valid_doublets = pylist_filter_pylist(word_neighbors(wrd1), word_is_legal) # find legal doublets
            doublet_lst = [] 
            if w2 in valid_doublets: # if w2 found
                return [w2] 
            else:
                for doublet in valid_doublets: # used for finding doublets that are "more valid"
                    for l in letter_lst:
                        if doublet not in doublet_lst:# checks if the doublets have the same letters at the same pos as w2
                            if l[0] == doublet[l[1]]: 
                                doublet_lst += [doublet]
                if len(doublet_lst) > 0:
                    return doublet_lst
                else:
                    return valid_doublets
        def gpath_bfs2(fnexts): # basically non-lazy version of gpath_bfs
            visited = set()
            def helper(qpths):
                while (True):
                    if qpths.empty():
                        return None
                    else:
                        pth1 = qpths.get()
                        for nx2 in fnexts(pth1[-1]):
                            if not nx2 in visited:
                                visited.add(nx2)
                                qpths.put(pth1 + (nx2,))
                                if w2 == nx2:
                                    return (pth1 + (nx2,))
            qpths = queue.Queue()
            visited.add(w1)
            qpths.put(tuple([w1]))
            return helper(qpths)
        doublet_stream = gpath_bfs2(valid_doublet_path)
        #return find_doublet_tuple(doublet_stream, 0) # gonna return the stream to figure out what to do next\
        
        return doublet_stream
    """
    Given two words w1 and w2, this function should
    return None if w1 and w2 do not for a doublet. Otherwise
    it returns a path connecting w1 and w2 that attests to the
    two words forming a doublet.
    """
####################################################
