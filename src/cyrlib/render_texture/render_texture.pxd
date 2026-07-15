from cyrlib.raylib.raylib cimport RenderTexture2D as r_texture_t
from cyrlib.texture.texture cimport Texture

cdef class RenderTexture:
    cdef r_texture_t _raw
    cdef Texture _texture, _depth

    @staticmethod
    cdef RenderTexture new(int width, int height)

    cdef void c_unload(self)
    cpdef void begin(self)
    cpdef void end(self)
