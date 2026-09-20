from cyrlib.raylib.raylib cimport Font as font_t
from cyrlib.texture.texture cimport Texture

cdef class Font:
    cdef font_t _raw
    cdef bint _is_owner
    cdef Texture _texture

    @staticmethod
    cdef inline Font new(font_t raw, bint is_owner=*)
    cdef inline void c_unload(self)