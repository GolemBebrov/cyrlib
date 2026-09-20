from cyrlib.raylib.raylib cimport Color as RlColor
from cyrlib.vector4.vector4 cimport Vector4

cdef inline unsigned char __clamp_byte(int val) noexcept:
    if val < 0: return <unsigned char>0
    if val > 255: return <unsigned char>255
    return <unsigned char>val

cdef inline float __clamp_float(float val) noexcept:
    if val < 0.0: return 0.0
    if val > 1.0: return 1.0
    return val

cdef inline RlColor color_new(int r, int g, int b, int a):
    cdef RlColor color
    color.r = __clamp_byte(r)
    color.g = __clamp_byte(g)
    color.b = __clamp_byte(b)
    color.a = __clamp_byte(a)
    return color

cdef class Color:
    cdef RlColor _raw

    @staticmethod
    cdef inline Color new(int r, int g, int b, int a):
        cdef Color color = Color.__new__(Color)
        color._raw.r = __clamp_byte(r)
        color._raw.g = __clamp_byte(g)
        color._raw.b = __clamp_byte(b)
        color._raw.a = __clamp_byte(a)
        return color

    cdef inline bint c_equal(self, Color other)
    cdef inline Vector4 c_normalize(self)
    cdef inline Color c_tint(self, Color tint)
    cpdef void fade(self, float alpha)
    cpdef int to_int(self)