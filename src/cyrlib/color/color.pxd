from cyrlib.raylib.raylib cimport Color as RlColor

cdef class Color:
    cdef RlColor _raw

    cdef inline unsigned char clamp_byte(self, int val) noexcept:
        if val < 0: return 0
        if val > 255: return 255
        return <unsigned char>val

    @staticmethod
    cdef inline Color new(int r, int g, int b, int a):
        cdef Color color = Color.__new__(Color)
        color._raw.r = color.clamp_byte(r)
        color._raw.g = color.clamp_byte(g)
        color._raw.b = color.clamp_byte(b)
        color._raw.a = color.clamp_byte(a)
        return color
