import cython_code1
import cv2
import time
import numpy as np
import pathlib
import os

os.chdir(pathlib.Path(__file__).parent)

target_path = "../target.jpg"
#target_path = r"D:\Downloads\AE066EBF-2434-4F5F-90C8-7275A221C6FA.jpg"
target:np.ndarray = cv2.imread(target_path)

start = time.perf_counter()
colors = np.array(((0,0,0), (255,0,0),(255,255,0),(255,0,255), (0,255,0),(0,255,255), (0,0,255), (255,255,255)),dtype=np.int32)

data = cython_code1.to_dithe(target, colors)

print(time.perf_counter()-start) #53sec
cv2.imwrite('./out.png', target)