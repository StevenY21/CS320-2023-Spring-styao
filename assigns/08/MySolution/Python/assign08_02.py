####################################################
#!/usr/bin/env python3
####################################################
"""
HX-2023-04-07: 20 points
You are required to implement the following function
generator_merge2 WITHOUT using streams. A solution that
uses streams is disqualified.
"""
def generator_merge2(gen1, gen2, lte3):
    """
    Given two generators gen1 and gen2 and a comparison
    function lte3, the function generator_merge2 returns
    another generator that merges the elements produced by
    gen1 and gen2 according to the order specified by lte3.
    The function generator_merge2 is expected to work correctly
    for both finite and infinite generators.
    """
    gen1x = next(gen1, None)
    gen2x = next(gen2, None)
    temp = None
    # initial statements to get a temp value
    if lte3(gen1x, gen2x): #if gen1 provides smaller value
        temp = (gen2x,2) # hold onto gen2 val
        yield gen1x
    else: # if gen2 gets smaller value
        temp = (gen1x,1) #hold onto gen1 val
        yield gen2x
    while True:
        if temp[0] == None: # when one of the generators are done
            if temp[1] == 1: # if gen1 done
                gen2x = next(gen2, None)
                if gen2x == None:
                    return None
                else:
                    yield gen2x
            else: # if gen2 done
                gen1x = next(gen1, None)
                if gen1x == None:
                    return None
                else:
                    yield gen1x
        elif temp[1] == 1: # if the holding value from gen1
            gen2x = next(gen2, None)
            if gen2x == None: # if nothing in gen2 anymore
                yield temp[0]
                temp = (gen2x, 2)
            elif lte3(temp[0], gen2x): # if gen1 value smaller
                yield temp[0]
                temp = (gen2x,2)
            else: # if gen2 value still smaller
                yield(gen2x)
        else: # if holding gen2 value
            gen1x = next(gen1, None)
            if gen1x == None: #nothing more in gen1
                yield temp[0]
                temp = (gen1x, 1)
            elif lte3(gen1x, temp[0]):
                yield gen1x
            else:
                yield temp[0]
                temp = (gen1x, 1)
####################################################
