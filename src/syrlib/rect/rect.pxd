cimport cython
from nv_raylib.vector2.vector2 cimport Vector2
from nv_raylib.vector4.vector4 cimport Vector4

@cython.final
cdef class Rect:
    cdef public Vector2 position
    cdef public Vector2 size

    @staticmethod
    cdef inline Rect new(Vector2 position, Vector2 size)

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
