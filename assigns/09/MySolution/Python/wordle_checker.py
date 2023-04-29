########################
# HX-2023-04-15: 10 points
########################
"""
Given two words w1 and w2 of the same length,
please implement a function wordle_hint(w1, w2)
that return a sequence of pairs (i, c) for each
character c in w2 where i indicates the color
of c according to the rule of the wordle game:
0: c does not appear in w1
1: c appears in w1 at the same position as it does in w2
2: c appears in w1 at a different position as it does in w2
Please note that the number of times (1, c) or (2, c) appearing
in the returned sequence must be less than or equal to the number
of times c appearing in w1.
For instance,
w1 = water and w2 = water
wordle_hint(w1, w2) =
(1, w), (1, a), (1, t), (1, e), (1, r)
For instance,
w1 = water and w2 = waste
wordle_hint(w1, w2) =
(1, w), (1, a), (0, s), (2, t), (2, e)
For instance,
w1 = abbcc and w2 = bbccd
wordle_hint(w1, w2) =
(2, b), (1, b), (2, c), (1, c), (0, d)
"""
########################################################################
def wordle_hint(w1, w2):
    if w1 == w2: # if both w1 and w2 are same word
        return [(1, c) for c in w1]
    else:
        wrd_hint = []
        w_length = range(len(w1)) 
        poslst = {c:0 for c in w1} #dictionary, with the chars being the keys and the number of instances of the char being the value
        chklst= []
        clist2 = []
        for i in w_length:
            c1 = w1[i]
            poslst[c1] += 1
            clist2 += [(i, w2[i])]
        for (j, c) in clist2:
            if w1[j] == c:
                wrd_hint += [(1, c)]
                poslst[c] -= 1
            else:
                wrd_hint += [(-1, c)] # -1 is just a temp value, this is a temp tuple to be modified later
                chklst += [j]
        for j in chklst: # checks the temp tuples to determine if it is 1 or 2
            i = wrd_hint[j][0]
            c = wrd_hint[j][1]
            if poslst[c] == 0:
                wrd_hint[j] = (0, c)
            else:
                wrd_hint[j] = (2, c)
                poslst[c] -= 1
        return wrd_hint
                        
    # pseudocode
    # extra worlde rules:
    # if the guess has a certain letter in all the correct positions then any extra usage would be 0
    # like original: apple, and guess: ppppp will get 01100

########################################################################
