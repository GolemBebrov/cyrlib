from nv_raylib.raylib.raylib cimport Color as RlColor
cdef class Color:
    def __init__(self, int r, int g, int b, int a = 255):
        cdef RlColor raw
        raw.r = self.clamp_byte(r)
        raw.g = self.clamp_byte(g)
        raw.b = self.clamp_byte(b)
        raw.a = self.clamp_byte(a)
        self._raw = raw

    def __repr__(self):
        return f"Color({self._raw.r}, {self._raw.g}, {self._raw.b}, {self._raw.a})"

    def __iter__(self):
        yield self._raw.r
        yield self._raw.g
        yield self._raw.b
        yield self._raw.a

    #Short
    @property
    def r(self):
        return self._raw.r

    @r.setter
    def r(self, int value):
        self._raw.r = self.clamp_byte(value)

    @property
    def g(self):
        return self._raw.g

    @g.setter
    def g(self, int value):
        self._raw.g = self.clamp_byte(value)

    @property
    def b(self):
        return self._raw.b

    @b.setter
    def b(self, int value):
        self._raw.b = self.clamp_byte(value)

    @property
    def a(self):
        return self._raw.a

    @a.setter
    def a(self, int value):
        self._raw.a = self.clamp_byte(value)

    #Long
    @property
    def red(self):
        return self._raw.r

    @red.setter
    def red(self, int value):
        self._raw.r = self.clamp_byte(value)

    @property
    def green(self):
        return self._raw.g

    @green.setter
    def green(self, int value):
        self._raw.g = self.clamp_byte(value)

    @property
    def blue(self):
        return self._raw.b

    @blue.setter
    def blue(self, int value):
        self._raw.b = self.clamp_byte(value)

    @property
    def alpha(self):
        return self._raw.a

    @alpha.setter
    def alpha(self, int value):
        self._raw.a = self.clamp_byte(value)
