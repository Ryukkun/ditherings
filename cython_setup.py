from distutils.core import setup, Extension
from Cython.Build import cythonize
from Cython.Compiler.Options import annotate
from numpy import get_include # cimport numpyを使う場合に必要

# 「sample」はpyxファイルごとに修正
annotate = True
ext = Extension("cython_code", sources=["cython_code.pyx"], include_dirs=['.', get_include()])
setup(name="dithe_cython", ext_modules=cythonize([ext],annotate=True))