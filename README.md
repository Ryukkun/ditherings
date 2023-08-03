# ditherings
限られた色で元の画像をできる限り鮮やかに再現すーるんーだよー

## 処理速度
| 方式 | フォルダ（言語） | 8色 | 1.12.2 color |
| :--- | :--- | :--- | :--- |
| 近似 | [python.2](python.2/) | 3.7 Sec | 6.7 Sec |
| 近似 | [cython.4](cython.4/) | 0.05 Sec | 1.14 Sec |
| 誤差拡散 | [python.1](python.1/) | 43 Sec | 56 Sec |
| 誤差拡散 | [cython.2](cython.2/) | 0.090 Sec | 1.23 Sec |
| 誤差拡散.Mk1 | [cython.3](cython.3/) | 0.064 Sec | 1.15 Sec |
| 誤差拡散.Mk1 | [java.1](java.1/) | 0.15 Sec | 2.36 Sec |
| 誤差拡散.Mk2 | [cython.5](cython.5/) | 0.045 Sec | 0.029 Sec |



## 画像
元画像
![元画像](target.jpg)

| 方式 | 8色 | 1.12.2 |
| :---: | :---: | :---: |
| 近似 | ![8近似](image/8color/近似.png) | ![1.12.2近似](image/1.12.2/近似.png) |
| 誤差拡散 | ![8誤差拡散](image/8color/誤差拡散.png) | ![1.12.2誤差拡散](image/1.12.2/誤差拡散.png) |
| 誤差拡散.Mk1 | ![8誤差拡散.Mk1](image/8color/誤差拡散.改.png) | ![1.12.2誤差拡散.Mk1](image/1.12.2/誤差拡散.改.png) |
| 誤差拡散.Mk2 | ![8誤差拡散.Mk2](image/8color/誤差拡散.Mk2.png) | ![1.12.2誤差拡散.Mk2](image/1.12.2/誤差拡散.Mk2.png) |