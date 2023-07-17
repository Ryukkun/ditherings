#cython : language_level=3, boundscheck=False, wraparound=False, initializedcheck=False, cdivision=True
import numpy as np
cimport numpy as np


cpdef inline to_dithe(unsigned char[:,:,:] target, unsigned char[:,:] colors):

    cdef:
        int total
        int last_total
        int color_index
        short[:] diffe = np.zeros(3, dtype=np.int16)
        short[:] res = np.zeros(3, dtype=np.int16)


    for i in range(target.shape[0]):
        diffe[0] = diffe[1] = diffe[2] = 0

        for ii in range(target.shape[1]):

            last_total = 2000000
            for iiii in range(3):
                res[iiii] = target[i,ii,iiii] + diffe[iiii]


            for iii in range(colors.shape[0]):
                total = 0
                for iiii in range(3):
                    
                    total += (colors[iii,iiii] - res[iiii]) ** 2

                if total < last_total:
                    last_total = total
                    color_index = iii

            for iiii in range(3):
                target[i,ii,iiii] = colors[color_index,iiii]
                if 0 < res[iiii]:
                    diffe[iiii] = res[iiii] - colors[color_index,iiii]
                else:
                    diffe[iiii] = res[iiii] + colors[color_index,iiii]
                


    return target