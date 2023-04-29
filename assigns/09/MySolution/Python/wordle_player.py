########################
# HX-2023-04-15: 20 points
########################
"""
Given a history of wordle hints, this function returns a
word as the player's guess.
"""
########################################################################

import random 

def wordle_guess(hints):
    guess = ["_" for i in range(len(hints[0]))]
    code2_c = {} # holds amt of instances of code 2 c
    emptypos = [1 for i in range(len(hints[0]))] # 1 means open 0 means has a char with code 1
    total_c_amt = {} # holds amt of each valid char, based on the most amt of times it appeared with code 1 or 2 in a single hint
    hint_c_amt = {} # holds amt of times each valid chars appeared inside the current hint 
    code1_c = {} # holds amt of all instances of code 1 for a char, or code 2 c placed down in valid spots
    c_invalid = {} # holds all the invalid spaces for c
    for hint in hints:
        #print(hint)
        for i in range(len(hint)):
            j = hint[i][0]
            c = hint[i][1]
            if j == 1 and emptypos[i] == 1: # if c at correct spot
                guess[i] = c 
                if code1_c.get(c) == None: # if first instance of code 1 for c in all hints
                    code1_c[c] = 1
                else: # if not 1st instance
                    code1_c[c] += 1
                if hint_c_amt.get(c) == None: # if first instance of c in this hint
                    hint_c_amt[c] = 1
                else: # if not first instance
                    hint_c_amt[c] += 1
                emptypos[i] = 0
            elif j == 2: # if c not at correct spot, but exists in word
                if c_invalid.get(c) == None: # if first instance of code 2 for c in all hints
                    c_invalid[c] = [i]
                else: # if not first instance of code 2 in all hints
                    c_invalid[c] += [i]
                if hint_c_amt.get(c) == None: # if first instance in this hint
                    hint_c_amt[c] = 1
                else: # if not first instance in this hint
                    hint_c_amt[c] += 1
                if code2_c.get(c) == None:
                    code2_c[c] = 1
                else:
                    code2_c[c] += 1
                if code1_c.get(c) == None: # since its not code 1, the new c will get a value of 0
                    code1_c[c] = 0
            elif j == 0: # if c not in word. This includes c's that are in word but over limit and not at correct spot
                if c_invalid.get(c) == None: # if first time seeing invalid c
                    c_invalid[c] = [i]
                else: # if not 1st time
                    c_invalid[c] += [i]
                if code1_c.get(c) == None: # since its not code 1, the new c will get a value of 0
                    code1_c[c] = 0
        #print('total c', hint_c_amt)
        #print('code1_c', code1_c)
        for key in hint_c_amt: # checks if max valid c's need to be changed
            if total_c_amt.get(key) == None: # first instance of c
                total_c_amt[key] = hint_c_amt[key]
            else: 
                if total_c_amt[key] < hint_c_amt[key]:
                    total_c_amt[key] = hint_c_amt[key]
        #print(total_c_amt.get('m'))
        hint_c_amt = {}
    #print(total_c_amt)
    #print(code1_c)
    #print(c_invalid)
    abcs = "abcdefghijklmnopqrstuvwxyz"
    for i in range(len(guess)):
        if guess[i] == "_":
            for c in total_c_amt:
                #print(i, c)
                #print(total_c_amt['m'])
                #print(code1_c['m'])
                if total_c_amt[c] > code1_c[c]:
                    if i not in c_invalid[c]:
                        guess[i] = c
                        code1_c[c] += 1
                        break
            if guess[i] == "_":
                for c in abcs:
                    if total_c_amt.get(c) == None and c_invalid.get(c) == None and code1_c.get(c) == None: # making sure the random letter is allowed
                        guess[i] = c

    res = ''
    for c in guess:
        res += c
    return res

########################################################################
