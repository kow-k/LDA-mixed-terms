# -*- coding:utf-8 -*-
import cython
## This source uses older, C-based style
##
def cy_gen_ngrams (list S, int n, bint check = False):
	"""
	take a string and returns the list of character n-grams generated out of it.
	"""
	##
	if check:
		print(f"#S: {S}; n: {n}")
	##
	if len(S) < n:
		return S
	## variables
	cdef:
		list segs, R, g
		int i
		str seg, b, c
	## main
	segs = [ seg for seg in S if len(seg) > 0 ]
	if check:
		print(f"segs: {segs}")
	R = [ ]
	for i in range(len(segs)):
		try:
			g = segs[ i : i + n ]
			if check:
				print(f"g: {g}")
			if len(g) == n:
				R.append(g)
		except IndexError:
			pass
	## return
	return R
##
def cy_gen_skippy_ngrams (list S, int n, int max_distance = 0, str missing_mark = "…", bint check = False):
	"""
	takes a list of segments and returns a list of skippy n-grams out of them.
	"""
	##
	if check:
		print(f"#S: {S}; n: {n}")
	##
	if len(S) < n:
		return S
	## variables
	cdef int i, j, k, last_k
	## The following turned out to be offensive
	#cdef list R, P, Rx, Q
	## generate target index list
	R = range(len(S))
	if check:
		print(f"#R: {R}")
	import itertools
	## implementation of restriction by max gap distance
	if max_distance == 0: ## max_distance-free
		P = [ p for p in itertools.combinations(R, r = n) if max(p) <= len(S) ]
	else: ## max_distance implementation
		Rx = [[ r for r in itertools.combinations(list(range(i, i + max_distance)), r = n) if max(r) < len(S) ] for i in R ]
		## flatten Rx
		P = [ ]
		for r in Rx:
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
					q.append(missing_mark)
					q.append(x)
				last_k = k
		#
		Q.append(q)
	## return result
	R = [ ]
	for q in Q:
		## remove the intial missing_mark wrongly generated
		if q[0] == missing_mark:
			R.append(q[1:])
		else:
			R.append(q)
	#
	return R
##
def cy_make_ngram_inclusive (list T, list S, int size, bint check = False):
	assert len(T) == len(S)
	## declare variables
	cdef int i
	cdef list R, supplement # including x in this causes error
	#cdef str x # This turns out to be offensive
	## main
	R = T
	if check:
		print(f"#R initial: {R}")
	for i, x in enumerate(R):
		supplement = [ x for x in S[i] if len(x) == size ]
		if check:
			print(f"#supplement to {i}: {supplement}")
		if len(supplement) > 0:
			x.extend(supplement)
	## return outcome
	return R

### end of file
