import os
import sys

import numpy
from Cython.Build import cythonize
from setuptools import Extension, setup

if sys.platform == "win32":
    c_opts = [
        "/std:c++17",
        "/O2",
        "/arch:AVX2",
        "/fp:fast",
        "/GL",
    ]
    l_opts = [
        "/LTCG",
    ]
else:
    c_opts = [
        "-std=c++17",
        "-O3",
        "-march=x86-64-v3",
        "-mavx2",
        "-mfma",
        "-ffast-math",
        "-flto",
    ]
    l_opts = [
        "-flto",
    ]

cython_directives = {
    "language_level": "3",
    "boundscheck": False,
    "wraparound": False,
    "cdivision": True,
    "nonecheck": False,
    "initializedcheck": False,
    "infer_types": True,
    "unraisable_tracebacks": True,
}


def get_extension(name: str, source: str) -> Extension:
    return Extension(
        name,
        [source],
        include_dirs=[numpy.get_include(), "src"],
        extra_compile_args=c_opts,
        extra_link_args=l_opts,
    )


def get_extensions():
    import glob

    pyx_files = glob.glob("src/nv_raylib/**/*.pyx", recursive=True)

    extensions = []
    for pyx in pyx_files:
        rel_path = os.path.relpath(pyx, "src")
        module_name = os.path.splitext(rel_path)[0].replace(os.path.sep, ".")

        extensions.append(get_extension(module_name, pyx))

    return cythonize(
        extensions,
        compiler_directives=cython_directives,
        annotate=True,
        include_path=["src"],
        nthreads=8,
    )


if __name__ == "__main__":
    setup(ext_modules=get_extensions(), package_dir={"": "src"})
