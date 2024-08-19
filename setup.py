#from distutils.core import setup # Seems like obsolete
from setuptools import setup
from Cython.Build import cythonize
setup(ext_modules = cythonize('cy_gen_ngrams.py'))
#setup(ext_modules = cythonize('cy_gen_ngrams_alt.py'))
