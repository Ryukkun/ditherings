#cython : language_level=3, boundscheck=False, wraparound=False, initializedcheck=False, cdivision=True


cpdef inline to_dithe(unsigned char[:,:,:] target, unsigned char[:,:] colors):

    cdef:
        int total
        int last_total
        int color_index


    for i in range(target.shape[0]):

        for ii in range(target.shape[1]):
            last_total = 2000000

            for iii in range(colors.shape[0]):
                total = 0
                for iiii in range(3):
                    total += (colors[iii,iiii] - target[i,ii,iiii]) ** 2

                if total < last_total:
                    last_total = total
                    color_index = iii

            for iiii in range(3):
                target[i,ii,iiii] = colors[color_index,iiii]
                


    return target