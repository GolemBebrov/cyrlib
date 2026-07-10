import glob
import os
import sys

import numpy
from Cython.Build import cythonize
from setuptools import Extension, setup

RAYLIB_INCLUDE_DIR = "deps/include"
RAYLIB_LIBS_DIR = "deps/libs"

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
    include_dirs = [numpy.get_include(), "src", RAYLIB_INCLUDE_DIR]
    library_dirs = []
    libraries = []
    extra_link_args = list(l_opts)

    if True:
        libraries.append("raylib")

        if sys.platform == "win32":
            library_dirs.append(os.path.join(RAYLIB_LIBS_DIR, "windows"))
            libraries.extend(["opengl32", "gdi32", "winmm", "user32", "shell32"])

        else:
            library_dirs.append(os.path.join(RAYLIB_LIBS_DIR, "linux"))
            extra_link_args.extend(
                ["-lGL", "-lm", "-lpthread", "-ldl", "-lrt", "-lX11"]
            )

    return Extension(
        name,
        [source],
        include_dirs=include_dirs,
        library_dirs=library_dirs,
        libraries=libraries,
        extra_compile_args=c_opts,
        extra_link_args=extra_link_args,
    )


def get_extensions():
    pyx_files = glob.glob("src/cyrlib/**/*.pyx", recursive=True)

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
