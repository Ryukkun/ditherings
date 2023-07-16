from distutils.core import setup
from Cython.Build import cythonize
import Cython.Compiler.Options
import numpy as np

Cython.Compiler.Options.annotate = True
setup(
    name = 'cython_code3',
    ext_modules = cythonize('cython_code3.pyx'),
    include_dirs = [np.get_include()]
    )