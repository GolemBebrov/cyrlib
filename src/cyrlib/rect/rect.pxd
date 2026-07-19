cimport cython

from cyrlib.raylib.raylib cimport Rectangle

from cyrlib.vector2.vector2 cimport Vector2
from cyrlib.vector4.vector4 cimport Vector4

@cython.final
cdef class Rect:
    cdef Rectangle _raw
    @staticmethod
    cdef inline Rect new(Rectangle rect)

    cpdef get_width(self)
    cpdef get_height(self)
    cpdef bint collide_point(self, object point)
    cpdef bint collide_point_vector2(self, Vector2 point)
    cpdef bint collide_point_tuple(self, tuple point)
    cpdef bint collide_point_list(self, list point)
    cpdef bint collide_rect(self, object other)
    cpdef bint collide_rect_vector4(self, Vector4 other)
    cpdef bint collide_rect_rect(self, Rect other)
    cpdef bint collide_rect_tuple(self, tuple other)
    cpdef bint collide_rect_list(self, list other)
    cpdef Vector4 get_vector4(self)
    cpdef tuple get_tuple(self)
