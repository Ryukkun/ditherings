#cython : language_level=3, boundscheck=False, wraparound=False, initializedcheck=False, cdivision=True

import time
import numpy as np
cimport numpy as np


cpdef inline to_dithe(unsigned char[:,:,:] target, unsigned char[:,:] colors):

    print("start")

    cdef:
        short color_index
        unsigned char[:] colors_ = calc_color(colors)
        float start = time.perf_counter()
        short[:] diffe = np.empty(3, dtype=np.int16)
        short[:] res = np.empty(3, dtype=np.int16)

        int DIV = 2
        int rowDif = 128
        int DIV_RowDif = rowDif / DIV
        int oneSideDif = rowDif/2
        int DIV_oneSideDif = oneSideDif / DIV
        int leftLimit = -oneSideDif
        int rightLimit = 256 + oneSideDif
        int DIV_Row = 256 / DIV + DIV_RowDif
        int DIV_Row2 = DIV_Row *DIV_Row
        int DIV_Row3 = DIV_Row2 * DIV_Row

    #print(f"colors_")

    for i in range(target.shape[0]):
        diffe[0] = diffe[1] = diffe[2] = 0

        for ii in range(target.shape[1]):

            for iiii in range(3):
                res[iiii] = target[i,ii,iiii] + diffe[iiii]

            
            color_index = colors_[ ((res[0]>>1)+DIV_oneSideDif) + (((res[1]>>1)+DIV_oneSideDif)*DIV_Row) + (((res[2]>>1)+DIV_oneSideDif)*DIV_Row2)]


            for iiii in range(3):
                target[i,ii,iiii] = colors[color_index,iiii]
                if 0 <= res[iiii]:
                    diffe[iiii] = (res[iiii] - colors[color_index,iiii]) >> 1
                else:
                    diffe[iiii] = (res[iiii] + colors[color_index,iiii]) >> 1


    print(time.perf_counter() - start)

    return target




cpdef inline calc_color(unsigned char[:,:] colors):

    cdef:
        int r, g, b
        int rr, gg, bb
        int row_ = 2
        int rowDif = 128 / row_
        int row = 256 / row_ + rowDif
        int row2 = row * row
        int row3 = row2 * row
        unsigned char[:] byte_ = np.empty(row3, dtype=np.uint8)
    

    for r in range(row):
        rr = r*row_-rowDif

        for g in range(row):
            gg = g*row_-rowDif

            for b in range(row):
                bb = b*row_-rowDif

                byte_[r + (g * row) + (b * row2)] = nearest_color_index(rr, gg, bb, colors)

    return byte_



cpdef inline unsigned char nearest_color_index(int r, int g, int b, unsigned char[:,:] colors):
    cdef:
        int total = 0
        int i
        int last_total = 20000000
        int color_index

    for i in range(colors.shape[0]):
        total = 0
        total += (colors[i,0] - r) * (colors[i,0] - r)
        total += (colors[i,1] - g) * (colors[i,1] - g)
        total += (colors[i,2] - b) * (colors[i,2] - b)

        if total < last_total:
            last_total = total
            color_index = i

    return color_index
