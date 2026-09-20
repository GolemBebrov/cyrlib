import glob
import os
import sys

from Cython.Build import cythonize
from setuptools import Extension, setup
from setuptools.command.build_ext import build_ext

RAYLIB_INCLUDE_DIR = "deps/include"
RAYLIB_LIBS_DIR = "deps/libs"

no_opt = sys.flags.optimize > 0
if "-O" in sys.argv:
    no_opt = True
    sys.argv[:] = [arg for arg in sys.argv if arg != "-O"]

if no_opt:
    os.environ["CFLAGS"] = "-O0 -pipe -g0 -w"
    os.environ["CXXFLAGS"] = "-O0 -pipe -g0 -w"

    if sys.platform == "win32":
        c_opts = [
            "/std:c++17",
            "/Od",
            "/MP",
            "/w",
        ]
        l_opts = []
    else:
        c_opts = [
            "-std=c++17",
            "-O0",
            "-pipe",
            "-fno-var-tracking",
            "-g0",
            "-w",
        ]
        l_opts = []

    cython_directives = {
        "language_level": "3",
        "boundscheck": True,
        "wraparound": True,
        "cdivision": False,
        "nonecheck": True,
        "initializedcheck": True,
        "infer_types": True,
        "unraisable_tracebacks": True,
    }
else:
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


class FastBuildExt(build_ext):
    """Параллельная компиляция C/C++ исходников компилятором."""
    def initialize_options(self):
        super().initialize_options()
        self.parallel = os.cpu_count() or 8


def get_extension(name: str, source: str) -> Extension:
    include_dirs = ["src", RAYLIB_INCLUDE_DIR]
    library_dirs = []
    libraries = ["raylib"]
    extra_link_args = list(l_opts)

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
        language="c++",
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
        annotate=not no_opt,
        include_path=["src"],
        nthreads=os.cpu_count() or 8,
    )


if __name__ == "__main__":
    setup(
        ext_modules=get_extensions(),
        package_dir={"": "src"},
        cmdclass={"build_ext": FastBuildExt},
    )