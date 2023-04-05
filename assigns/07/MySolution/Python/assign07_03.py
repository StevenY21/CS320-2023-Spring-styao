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
        letter_lst = int1_foldleft(len(w1), [], diff_letters) # accumulates a list of all the differing letters and the positions
        print(letter_lst)
        def next_valid_doublet(wrd, letters): 
            #return pylist_filter_pylist(word_neighbors(wrd), word_is_legal)
            actual_words = pylist_filter_pylist(word_neighbors(wrd), word_is_legal) # first filters for actual words 
            return actual_words
            #def valid_doublet(word): 
                #for l in letters:
                    #if l[0] in word:
                        #return True
                #return False
            #valid_words = pylist_filter_pylist(actual_words, valid_doublet) # filters for valid doublets
            #return valid_words
        def valid_doublet_path(doublet_pth): # takes a doublet path and forms next doublet in path
            wrd = doublet_pth[-1] # takes most recent doublet
            if wrd == w2:
                return []
            valid_doublets = next_valid_doublet(wrd, letter_lst) # find next valid doublets

            doublet_lst = []
            doublet_lst2 = []
            if w2 in valid_doublets:
                # print("found it")
                return [doublet_pth + (w2, )] 
            else:
                for wrd in valid_doublets:
                    if not(wrd in doublet_pth):
                        doublet_lst += [doublet_pth + (wrd,)]
                        for l in letter_lst:
                            if l[0] == wrd[l[1]]:
                                doublet_lst2 += [doublet_pth + (wrd,)]
                #doublet_lst = [doublet_pth + (wrd,) for wrd in valid_doublets ] # creates a list of all possible new doublet paths
                if len(doublet_lst2) > 0:
                    return doublet_lst2
                else:
                    return doublet_lst
        def gtree_bfs(nxs, fchildren): # runs a bfs alg to find the valid children in each row
            def helper(nxs):
                if nxs.empty():
                    return strcon_nil()
                else:
                    nx1 = nxs.get()
                    #print("nx1", nx1)
                    for nx2 in fchildren(nx1):
                        #print(nx2)
                        nxs.put(nx2) # all the children accumulate toward the end
                    return strcon_cons(nx1, gtree_bfs(nxs, fchildren))
            return lambda: helper(nxs)
        def find_doublet_tuple(fxs):
            cxs = fxs() # "activates" stream function
            fxs = cxs.cons2 # gets the tail of the stream
            #print(cxs.cons1) # gets the head of stream
            #print(i)
            if cxs.cons1[-1] == w2: # checks if head has w2
                return cxs.cons1
            else:
                return find_doublet_tuple(fxs)
        # get all the words from wordneighbors that are legal and also have the letters that differ in w2
        # from there, we can run wordneighbors again and check which ones have another letter in the right position
        # keep on going until we get there
        nxs = queue.Queue() # initiates a queue to hold the letters
        nxs.put((w1,)) # puts the initial word into the letters
        # does a bfs through a tree of all valid doublet combinations 
        # valid in the sense that it contains the differing letters at the specific spot
        def gpath_bfs(nxs, fnexts):
            visited = set()
            def helper(qpths):
                if qpths.empty():
                    return strcon_nil()
                else:
                    pth1 = qpths.get()
                    print(pth1[-1])
                    # print("gtree_bfs: helper: nx1 = ", nx1)
                    for nx2 in fnexts(pth1[-1]):
                        if not nx2 in visited:
                            visited.add(nx2)
                            qpths.put(pth1 + (nx2,))
                    return strcon_cons(pth1, lambda: helper(qpths))
        # end-of-(if(qnxs.empty())-then-else)
            qpths = queue.Queue()
            for nx0 in nxs:
                print(nx0)
                visited.add(nx0)
                qpths.put(tuple([nx0]))
            return lambda: helper(qpths)
        doublet_stream = gtree_bfs(nxs, valid_doublet_path) 
        doublet_stream = gpath_bfs((w1,), valid_doublet_path)
        #return find_doublet_tuple(doublet_stream, 0) # gonna return the stream to figure out what to do next\
        return find_doublet_tuple(doublet_stream)
    """
    Given two words w1 and w2, this function should
    return None if w1 and w2 do not for a doublet. Otherwise
    it returns a path connecting w1 and w2 that attests to the
    two words forming a doublet.
    """
print(doublet_bfs_test('hi', 'it'))
# stream_iforall\
    #(doublet_bfs_test('never', 'again'), \
           # lambda i, x: i < 1000 and not(print(i,":",x)))
#print(word_is_legal('bi'))
####################################################
