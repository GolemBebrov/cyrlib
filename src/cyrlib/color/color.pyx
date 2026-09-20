from cyrlib.raylib.raylib cimport Color as RlColor, ColorIsEqual, ColorNormalize, ColorTint, ColorToInt
from cyrlib.vector4.vector4 cimport Vector4,vec4_from_struct
cdef class Color:
    def __init__(self, int r, int g, int b, int a = 255):
        cdef RlColor raw
        raw.r = __clamp_byte(r)
        raw.g = __clamp_byte(g)
        raw.b = __clamp_byte(b)
        raw.a = __clamp_byte(a)
        self._raw = raw

    @staticmethod
    def from_normalized(Vector4 vector):
        return Color.new(int(vector.data.x * 255), int(vector.data.y * 255), int(vector.data.z * 255), int(vector.data.w * 255))

    def __repr__(self):
        return f"Color({self._raw.r}, {self._raw.g}, {self._raw.b}, {self._raw.a})"

    def __iter__(self):
        yield self._raw.r
        yield self._raw.g
        yield self._raw.b
        yield self._raw.a
    
    def __len__(self):
        return 4

    def __eq__(self, Color other) -> bool:
        return self.c_equal(other)

    cdef inline bint c_equal(self, Color other):
        return ColorIsEqual(self._raw, other._raw)
    
    cdef inline Vector4 c_normalize(self):
        return Vector4.new(self._raw.r / 255.0, self._raw.g / 255.0, self._raw.b / 255.0, self._raw.a / 255.0)

    cdef inline Color c_tint(self, Color tint):
        cdef RlColor raw = ColorTint(self._raw, tint._raw)
        return Color.new(raw.r, raw.g, raw.b, raw.a)
    
    def tint(self, Color tint) -> Color:
        return self.c_tint(tint)

    def normalize(self) -> Vector4:
        return self.c_normalize()

    def equal(self, Color other) -> bool:
        return self.c_equal(other)

    cpdef void fade(self, float alpha):
        self._raw.a = <unsigned char>(__clamp_float(alpha) * 255)
    
    cpdef int to_int(self):
        return ColorToInt(self._raw) 

    #Short
    @property
    def r(self):
        return self._raw.r

    @r.setter
    def r(self, int value):
        self._raw.r = __clamp_byte(value)

    @property
    def g(self):
        return self._raw.g

    @g.setter
    def g(self, int value):
        self._raw.g = __clamp_byte(value)

    @property
    def b(self):
        return self._raw.b

    @b.setter
    def b(self, int value):
        self._raw.b = __clamp_byte(value)

    @property
    def a(self):
        return self._raw.a

    @a.setter
    def a(self, int value):
        self._raw.a = __clamp_byte(value)

    #Long
    @property
    def red(self):
        return self._raw.r

    @red.setter
    def red(self, int value):
        self._raw.r = __clamp_byte(value)

    @property
    def green(self):
        return self._raw.g

    @green.setter
    def green(self, int value):
        self._raw.g = __clamp_byte(value)

    @property
    def blue(self):
        return self._raw.b

    @blue.setter
    def blue(self, int value):
        self._raw.b = __clamp_byte(value)

    @property
    def alpha(self):
        return self._raw.a

    @alpha.setter
    def alpha(self, int value):
        self._raw.a = __clamp_byte(value)
