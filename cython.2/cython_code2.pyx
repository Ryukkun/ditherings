#cython : language_level=3, boundscheck=False, wraparound=False, initializedcheck=False, cdivision=True
cimport numpy as cnp
import numpy as np


cpdef inline to_dithe(cnp.ndarray[unsigned char, ndim=3] target, unsigned char[:,:] colors):

    cdef:
        short[:,:,:] target_copy = target.astype(np.int16)
        int col_count = target_copy.shape[0]
        int row_count = target_copy.shape[1]
        int colors_count = colors.shape[0]
        int total
        int last_total
        int color_index
        int nii = 0
        int ni = 0
        int nni = -2
        short[:] diffe = target_copy[0][0]


    for i in range(col_count):
        ni += 1
        nii = 0
        nni = -2

        for ii in range(row_count):
            nii += 1
            nni += 1
            last_total = 2000000
            for iii in range(colors_count):
                total = 0
                for iiii in range(3):
                    total += (<short>colors[iii,iiii] - target_copy[i,ii,iiii]) ** 2

                if total < last_total:
                    last_total = total
                    color_index = iii

            for iiii in range(3):
                if 0 < target_copy[i,ii,iiii]:
                    diffe[iiii] = target_copy[i,ii,iiii] - colors[color_index,iiii]
                else:
                    diffe[iiii] = target_copy[i,ii,iiii] + colors[color_index,iiii]
                target[i,ii,iiii] = colors[color_index,iiii]


            if nii < row_count:
                for iii in range(3):
                    target_copy[i,nii,iii] += <short>(diffe[iii] * 0.4375)
                if ni < col_count:
                    for iii in range(3):
                        target_copy[ni,nii,iii] += <short>(diffe[iii] * 0.0625)

            if ni < col_count:
                for iii in range(3):
                    target_copy[ni,ii,iii] += <short>(diffe[iii] * 0.3125)
                if 0 <= nni:
                    for iii in range(3):
                        target_copy[ni,nni,iii] += <short>(diffe[iii] * 0.1865)

    return target