import cv2
import time
import numpy as np

target_path = "/Users/yuma/Downloads/F1HNcukaMAA4QJC.jpg"
target:np.ndarray = cv2.imread(target_path)

colors = np.array(((0,0,0), (255,0,0), (0,255,0), (0,0,255), (255,255,255)),dtype=np.int32)

def euclidean(tcolor:np.ndarray) -> np.ndarray:
    return colors[((colors-tcolor)**2).sum(axis=1).argmin()]

start = time.perf_counter()
# print(euclidean(np.array((127,128,128), dtype=np.uint8)))
target_copy = target.copy().astype(np.int16)
col_count = target.shape[0]
row_count = target.shape[1]
for i, row in enumerate(target_copy):
    for ii, data in enumerate(row):
        nearest = euclidean(data)
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
# 28 ~ 37sec
print(time.perf_counter()-start)
cv2.imwrite('./python.png', target)