cimport numpy as cnp
import numpy as np
cimport cython
from cython import boundscheck, wraparound


cpdef inline to_dithe(cnp.ndarray[cnp.npy_uint8, ndim=3] target, cnp.ndarray[int, ndim=2] colors):

    cdef:
        cnp.ndarray[short, ndim=3] target_copy = target.copy().astype(np.int16)
        int col_count = target.shape[0]
        int row_count = target.shape[1]
        int i = 0
        int ii = 0
        cnp.ndarray[short, ndim=2] row
        cnp.ndarray[short, ndim=1] data
        cnp.ndarray[int, ndim=1] nearest
        cnp.ndarray[int, ndim=1] diffe
        bint hasbehind
        bint hasnext
        bint hasnextrow
    
    with boundscheck(False), wraparound(False):
        for row in target_copy:
            ii = 0
            for data in row:
                nearest = colors[((colors-data)**2).sum(axis=1).argmin()]
                target[i][ii] = nearest
                diffe = data - nearest

                hasnext = ii+1 < row_count
                hasnextrow = i+1 < col_count
                hasbehind = 0 <= ii-1


                if hasnext:
                    target_copy[i][ii+1] = target_copy[i][ii+1] + diffe*0.4375
                    if hasnextrow:
                        target_copy[i+1][ii+1] = target_copy[i+1][ii+1] + diffe*0.0625

                if hasnextrow:
                    target_copy[i+1][ii] = target_copy[i+1][ii] + diffe*0.3125
                    if hasbehind:
                        target_copy[i+1][ii-1] = target_copy[i+1][ii-1] + diffe*0.1865
                        
                ii += 1
            i += 1
    return target