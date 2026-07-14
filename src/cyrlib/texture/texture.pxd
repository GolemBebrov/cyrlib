from cyrlib.raylib.raylib cimport Texture as texture_t
from cyrlib.image.image cimport Image

cdef class Texture:
    cdef texture_t _raw
    cdef int _filter, _wrap

    @staticmethod
    cdef Texture new(texture_t struct)

    @staticmethod
    cdef Texture c_load(str file_name)

    @staticmethod
    cdef Texture c_load_from_image(Image image)

    cdef void c_unload(self)
