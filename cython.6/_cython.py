import cython_code
import cv2
import time
import numpy as np
import pathlib
import os

os.chdir(pathlib.Path(__file__).parent)
target_path = "../target.jpg"
#target_path = "../targetRGB.png"

target:np.ndarray = cv2.imread(target_path)

start = time.perf_counter()
#colors = np.array(((0,0,0), (255,0,0),(255,255,0),(255,0,255), (0,255,0),(0,255,255), (0,0,255), (255,255,255)),dtype=np.uint8)
colors = np.array(((9, 125, 39),(9, 153, 48),(27, 178, 56),(7, 94, 29),(74, 164, 115),(13, 201, 140),(247, 233, 163),(130, 123, 86),(140, 140, 140),(171, 171, 171),(199, 199, 199),(105, 105, 105),(180, 0, 0),(220, 0, 0),(255, 0, 0),(135, 0, 0),(112, 112, 180),(138, 138, 220),(160, 160, 255),(84, 84, 135),(117, 117, 117),(144, 144, 144),(167, 167, 167),(88, 88, 88),(0, 87, 0),(0, 106, 0),(0, 124, 0),(0, 65, 0),(180, 180, 180),(220, 220, 220),(255, 255, 255),(135, 135, 135),(115, 118, 129),(141, 144, 158),(164, 168, 184),(86, 88, 97),(106, 76, 54),(130, 94, 66),(151, 109, 77),(79, 57, 40),(79, 79, 79),(96, 96, 96),(112, 112, 112),(59, 59, 59),(45, 45, 180),(55, 55, 220),(64, 64, 255),(33, 33, 135),(100, 84, 50),(123, 102, 62),(143, 119, 72),(75, 63, 38),(180, 177, 172),(220, 217, 211),(255, 252, 245),(135, 133, 129),(152, 89, 36),(186, 109, 44),(216, 127, 51),(114, 67, 27),(125, 53, 152),(153, 65, 186),(178, 76, 216),(94, 40, 114),(72, 108, 152),(88, 132, 186),(102, 153, 216),(54, 81, 114),(161, 161, 36),(197, 197, 44),(229, 229, 51),(121, 121, 27),(89, 144, 17),(109, 176, 21),(127, 204, 25),(67, 108, 13),(170, 89, 116),(208, 109, 142),(242, 127, 165),(128, 67, 87),(53, 53, 53),(65, 65, 65),(76, 76, 76),(40, 40, 40),(108, 108, 108),(132, 132, 132),(153, 153, 153),(81, 81, 81),(53, 89, 108),(65, 109, 132),(76, 127, 153),(40, 67, 81),(89, 44, 125),(109, 54, 153),(127, 63, 178),(67, 33, 94),(36, 53, 125),(44, 65, 153),(51, 76, 178),(27, 40, 94),(72, 53, 36),(88, 65, 44),(102, 76, 51),(54, 40, 27),(72, 89, 36),(88, 109, 44),(102, 127, 51),(54, 67, 27),(108, 36, 36),(132, 44, 44),(153, 51, 51),(81, 27, 27),(17, 17, 17),(21, 21, 21),(25, 25, 25),(13, 13, 13),(176, 168, 54),(215, 205, 66),(250, 238, 77),(132, 126, 40),(64, 154, 150),(79, 188, 183),(92, 219, 213),(48, 115, 112),(52, 90, 180),(63, 110, 220),(74, 128, 255),(39, 67, 135),(0, 153, 40),(0, 187, 50),(0, 217, 58),(0, 114, 30),(91, 60, 34),(111, 74, 42),(129, 86, 49),(68, 45, 25),(79, 1, 0),(96, 1, 0),(112, 2, 0),(59, 1, 0),(147, 124, 113),(180, 152, 138),(209, 177, 161),(110, 93, 85),(112, 57, 25),(137, 70, 31),(159, 82, 36),(84, 43, 19),(105, 61, 76),(128, 75, 93),(149, 87, 108),(78, 46, 57),(79, 76, 97),(96, 93, 119),(112, 108, 138),(59, 57, 73),(131, 93, 25),(160, 114, 31),(186, 133, 36),(98, 70, 19),(72, 82, 37),(88, 100, 45),(103, 117, 53),(54, 61, 28),(112, 54, 55),(138, 66, 67),(160, 77, 78),(84, 40, 41),(40, 28, 24),(49, 35, 30),(57, 41, 35),(30, 21, 18),(95, 75, 69),(116, 92, 84),(135, 107, 98),(71, 56, 51),(61, 64, 64),(75, 79, 79),(87, 92, 92),(46, 48, 48),(86, 51, 62),(105, 62, 75),(122, 73, 88),(64, 38, 46),(53, 43, 64),(65, 53, 79),(76, 62, 92),(40, 32, 48),(53, 35, 24),(65, 43, 30),(76, 50, 35),(40, 26, 18),(53, 57, 29),(65, 70, 36),(76, 82, 42),(40, 43, 22),(100, 42, 32),(122, 51, 39),(142, 60, 46),(75, 31, 24),(26, 15, 11),(31, 18, 13),(37, 22, 16),(19, 11, 8)),dtype=np.uint8)

data = cython_code.to_dithe(target, colors)

print(time.perf_counter()-start) #0.08sec
cv2.imwrite('./out.png', target)