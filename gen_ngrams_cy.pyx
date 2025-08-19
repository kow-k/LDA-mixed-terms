"""
A collection of Cython functions to handle n-grams, continuous (= regular) and discontinous (= skippy)

history

2025/08/19 i) refactored code; ii) added extended_skippy_ngrams(..)
"""

import cython

##
def string_elements (Q: cython.list, sep: cython.str = " ", gap_mark: cython.str = "…", check: cython.bint = False):

    ## variables
    #q: cython.list
    R: cython.list

    ## main
    R = [ ]
    for q in Q:
        ## remove the intial missing_mark wrongly generated
        if q[0] == gap_mark:
            R.append(q[1:])
        else:
            R.append(q)
    #
    return ([ sep.join(r) for r in R ])

##
def gen_ngrams (S: cython.list, n: cython.int, as_list: cython.bint = True, sep: cython.str = "", check: cython.bint = False):
    """
    take a string and returns the list of character n-grams generated out of it.
    """
    
    if check:
        print(f"#taking {S} as input for {n}-gram")

    ## variables
    #seg:  cython.str
    #b:    cython.str
    #c:    cython.str
    i:    cython.int
    segs: cython.list
    R:    cython.list
    g:    cython.list

    ## filter out empty elements
    segs = [ seg for seg in S if len(seg) > 0 ]
    
    ## main
    if len(segs) <= n:
        if as_list:
            return [ segs ]
        else:
            return [ sep.join(segs) ]
    
    ## body
    R = [ ]
    for i in range(len(segs)):
        try:
            g = segs[ i : i + n ]
            if check:
                print(f"#g: {g}")
            if len(g) == n:
                R.append(g)
        except IndexError:
            pass
    
    ## return
    if as_list:
        return R
    else:
        return string_elements (R, sep = sep)

##
def gen_skippy_ngrams (S: cython.list, n: cython.int, max_gap_size = None, gap_mark: cython.str = "…", as_list: cython.bint = True, sep: cython.str = " ", check: cython.bint = False):
    """
    takes a list of segments and returns a list of skippy n-grams out of them.
    """
    ##
    if check:
        print(f"#taking {S} for skippy {n}-gram")
    ##
    segs = [ seg for seg in S if len(seg) > 0 ]
    ##
    if len(segs) <= n:
        if as_list:
            return [ segs ]
        else:
            return [ sep.join(segs) ]
    
    ## variables
    #i:       cython.int
    j:       cython.int
    k:       cython.int
    last_k:  cython.int
    #O, P, R, Q: cython.list # not work
    O: cython.list
    P: cython.list
    #R: cython.range # not accepted
    R: cython.list
    Q: cython.list
    
    ## generate target index list
    R = list(range(len(S))) # list(..) is necessary
    if check:
        print(f"#R: {R}")
    
    ## implementation of restriction by max gap distance
    import itertools
    if max_gap_size is None: ## max_distance-free
        P = [ p for p in itertools.combinations(R, r = n) if max(p) <= len(S) ]
    else: ## max_distance implementation
        O = [[ r for r in itertools.combinations(list(range(i, i + max_gap_size)), r = n) if max(r) < len(S) ] for i in R ]
        ## flatten O
        P = [ ]
        for r in O:
            P.extend(r)
    
    ## generate sub-lists
    Q = [ ]
    for p in P:
        q = [ ]
        for j in range(len(p)):
            k = p[j]; x = S[k]
            if k == 0:
                q.append(x)
                last_k = 0
            else:
                if (last_k + 1) == k:
                    q.append(x)
                else:
                    q.append(gap_mark)
                    q.append(x)
                last_k = k
        #
        Q.append(q)
    
    ## cleaning result
    R = [ ]
    for q in Q:
        ## remove the intial missing_mark wrongly generated
        if q == gap_mark:
            pass
        elif q[0] == gap_mark:
            R.append(q[1:])
        else:
            R.append(q)
    
    ## return result
    if as_list:
        return R
    else:
        return string_elements(R, sep = sep, gap_mark = gap_mark)

## aliases
gen_sk_ngrams = gen_skippy_ngrams

##
def gen_extended_skippy_ngrams (S: cython.list, n: cython.int, max_gap_size = None, gap_mark: cython.str = "…", as_list: cython.bint = True, sep: cython.str = " ", check: cython.bint = False):
    """
    takes a list of segments and returns a list of skippy n-grams out of them.
    """
    ##
    if check:
        print(f"#taking {S} for skippy {n}-gram")
    ##
    segs = [ seg for seg in S if len(seg) > 0 ]
    ##
    if len(segs) <= n:
        if as_list:
            return [ segs ]
        else:
            return [ sep.join(segs) ]
    
    ## variables
    j:       cython.int
    k:       cython.int
    last_k:  cython.int
    O: cython.list
    P: cython.list
    R: cython.list
    Q: cython.list
    
    ## generate target index list
    S_len = len(S)
    end_pos = (S_len - 1)
    if check:
        print(f"S_len: {S_len}")
    
    ##
    R = list(range(len(S))) # list(..) is necessary
    if check:
        print(f"#R: {R}")
    
    ## implementation of restriction by max gap distance
    import itertools
    if max_gap_size is None: ## max_distance-free
        P = [ p for p in itertools.combinations(R, r = n) if max(p) <= len(S) ]
    else: ## max_distance implementation
        O = [[ r for r in itertools.combinations(list(range(i, i + max_gap_size)), r = n) if max(r) < len(S) ] for i in R ]
        ## flatten O
        P = [ ]
        for r in O:
            P.extend(r)
    
    ## generate substrings
    Q = [ ]
    for p in P:
        if check:
            print(f"#p: {p}")
        q = [ ]
        ## irrelevant cases
        if len(p) < 1:
            pass
        ## cases where len(p) > 1
        elif len(p) >= 2:
            for i in range(len(p)):
                try:
                    sec = p[i : i+2]
                    if check:
                        print(f"#sec: {sec}")
                    pos, next_pos = sec[0], sec[1]
                except IndexError:
                    pos, next_pos = p[i], p[i]
                gap = (next_pos - pos)
                if check:
                    print(f"#pos: {pos}; next_pos: {next_pos}")
                    print(f"#gap: {gap}")
                seg = S[pos]
                if gap > 1:
                    if pos == 0:
                        q.append (seg)
                        q.append (gap_mark)
                    elif pos == end_pos:
                        q.append (seg)
                    else:
                        q.append (gap_mark)
                        q.append (seg)
                        q.append (gap_mark)
                elif gap == 1:
                    if pos == 0:
                        q.append (seg)
                    elif pos == end_pos:
                        q.append (seg)
                    else:
                        q.append (gap_mark)
                        q.append (seg)
                else:
                    if pos == 0:
                        q.append (seg)
                    elif pos == end_pos:
                        q.append (seg)
                    else:
                        q.append (seg)
                        q.append (gap_mark)
        ## cases where len(p) ==  1
        else:
            for pos in p:
                if check:
                    print(f"#pos: {pos}")
                seg = S[pos]
                if   ( pos == 0 ):
                    q.append(seg)
                    q.append(gap_mark)
                elif ( pos == (S_len - 1)):
                    q.append(gap_mark)
                    q.append(seg)
                else:
                    q.append(gap_mark)
                    q.append(seg)
                    q.append(gap_mark)
        ## singlify repeated missing_marks
        q2 = [ ]
        last = ""
        for x in q:
            if x != last:
                q2.append(x)
            last = x
        q = q2
        ## update
        Q.append(q)
        
    ## return result
    if as_list:
        return Q
    else:
        return string_elements(Q, sep = sep, gap_mark = gap_mark)

## aliases
gen_ext_skippy_ngrams = gen_extended_skippy_ngrams
gen_ext_sk_ngrams = gen_extended_skippy_ngrams

##
def make_ngram_inclusive (T: cython.list, S: cython.list, inclusion_degree: cython.int = 0, gap_mark: cython.str = "…", check: cython.bint = False):
    """
    takes a list of n-grams, make them inclusive with a given degree of inclusion
    """

    assert len(T) == len(S)
    
    ## variables
    max_len: cython.int
    R: cython.list
    supplement: cython.list
    
    R = T
    if check:
        print(f"#R initial: {R}")
    
    ## main
    if inclusion_degree > 0:
        max_len = max(len(x) for x in T)
        inclusion_len_limit = (max_len - inclusion_degree)
        assert inclusion_len_limit >= 0
        for i, r in enumerate(R):
            supplement = [ x for x in S[i] if len(x) >= inclusion_len_limit or x == gap_mark ]
            if check:
                print(f"#supplement to {i}: {supplement}")
            if len(supplement) > 0:
                r.extend(supplement) # updates the elements of R
    else:
        pass
    
    ## return outcome
    return R

### end of file