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
        int iii

    print("colors_")

    for i in range(target.shape[0]):
        diffe[0] = diffe[1] = diffe[2] = 0

        for ii in range(target.shape[1]):

            for iiii in range(3):
                res[iiii] = target[i,ii,iiii] + diffe[iiii]


            #iii = res[0] + (res[1]*256) + (res[2]*65536)
            #if 0 <= iii < 16777216 and 0 <= res[0] and 0 <= res[1] and 0 <= res[2]:
            #    color_index = colors_[iii]
            iii = (res[0]>>1) + (res[1]>>1<<7) + (res[2]>>1<<14)
            if 0 <= iii < 2097152 and 0 <= res[0] and 0 <= res[1] and 0 <= res[2]:
                color_index = colors_[iii]
            else:
                color_index = nearest_color_index(res[0], res[1], res[2], colors)


            for iiii in range(3):
                target[i,ii,iiii] = colors[color_index,iiii]
                if 0 < res[iiii]:
                    diffe[iiii] = (res[iiii] - colors[color_index,iiii]) >> 1
                else:
                    diffe[iiii] = (res[iiii] + colors[color_index,iiii]) >> 1

                

    print(time.perf_counter() - start)

    return target




cpdef inline calc_color(unsigned char[:,:] colors):

    cdef:
        int r, g, b
        #unsigned char[:] byte_ = np.empty(16777216, dtype=np.uint8)
        unsigned char[:] byte_ = np.empty(2097152, dtype=np.uint8)
        int rr, gg, bb
    
#    for r in range(256):
#
#        for g in range(256):
#
#            for b in range(256):
#
#                byte_[r + (g * 256) + (b * 65536)] = nearest_color_index(r, g, b, colors)

    for r in range(128):
        rr = r*2

        for g in range(128):
            gg = g*2

            for b in range(128):
                bb = b*2

                byte_[r + (g * 128) + (b * 16384)] = nearest_color_index(rr, gg, bb, colors)

    return byte_



cpdef inline unsigned char nearest_color_index(int r, int g, int b, unsigned char[:,:] colors):
    cdef:
        int total = 0
        int i
        int last_total = 2000000
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
