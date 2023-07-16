import cython_code
import cv2
import numpy as np

target_path = "/Users/yuma/Downloads/F1HNcukaMAA4QJC.jpg"
target:np.ndarray = cv2.imread(target_path)

colors = np.array(((0,0,0), (255,0,0), (0,255,0), (0,0,255), (255,255,255)),dtype=np.int32)

data = cython_code.to_dithe(target, colors)

cv2.imwrite('./cython.png', target)