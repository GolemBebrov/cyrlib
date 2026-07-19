from cyrlib.vector2.vector2 cimport Vector2
from cyrlib.vector4.vector4 cimport Vector4
from cyrlib.raylib.raylib cimport Rectangle


cdef class Rect:
    @staticmethod
    cdef inline Rect new(Rectangle rectangle):
        cdef Rect rect = Rect.__new__(Rect)
        rect._raw = rectangle
        return rect

    def __init__(self, *args):
        cdef int nargs = len(args)
        cdef object arg_0, arg_1, arg_2, arg_3
        if nargs == 0:
            self._raw = Rectangle(0, 0, 0, 0)
        elif nargs == 1:
            arg_0 = args[0]
            if isinstance(arg_0, Vector2):
                self._raw = Rectangle(0, 0, arg_0.x, arg_0.y)
            elif isinstance(arg_0, Rect):
                self._raw = Rectangle(<Rect>arg_0._raw.x, <Rect>arg_0._raw.y, <Rect>arg_0._raw.width, <Rect>arg_0._raw.height)
            elif isinstance(arg_0, Vector4):
                self._raw = Rectangle((<Vector4>arg_0).x, (<Vector4>arg_0).y, (<Vector4>arg_0).z, (<Vector4>arg_0).w)
            elif isinstance(arg_0, (tuple, list)):
                if len(arg_0) != 4:
                    raise ValueError("list/tuple for rect must have 4 elements")
                self._raw = Rectangle(arg_0[0], arg_0[1], arg_0[2], arg_0[3])
            else:
                raise ValueError("Rect takes Vector2, Rect, Vector4, or list/tuple of length 4")
        elif nargs == 2:
            arg_0 = args[0]
            arg_1 = args[1]
            if isinstance(arg_0, Vector2):
                self._raw = Rectangle(arg_0.x, arg_0.y, arg_1.x, arg_1.y)
            elif isinstance(arg_0, (list, tuple)) and len(arg_0) == 2:
                self._raw = Rectangle(arg_0[0], arg_0[1], arg_1[0], arg_1[1])
            else:
                raise ValueError("First argument must be a Vector2 or list/tuple of length 2")
            if isinstance(arg_1, Vector2):
                self._raw = Rectangle(0, 0, arg_1.x, arg_1.y)
            elif isinstance(arg_1, (list, tuple)) and len(arg_1) == 2:
                self._raw = Rectangle(0, 0, arg_1[0], arg_1[1])
            else:
                raise ValueError("Second argument must be a Vector2 or list/tuple of length 2")
        elif nargs == 4:
            self._raw = Rectangle(args[0], args[1], args[2], args[3])
        else:
            raise TypeError(f"Rect expected 0, 1, 2, or 4 arguments, got {nargs}")

    @property
    def x(self):
        return self._raw.x

    @x.setter
    def x(self, value):
        self._raw.x = value

    @property
    def y(self):
        return self._raw.y

    @y.setter
    def y(self, value):
        self._raw.y = value

    @property
    def w(self):
        return self._raw.width

    @w.setter
    def w(self, value):
        self._raw.width = value

    @property
    def h(self):
        return self._raw.height

    @h.setter
    def h(self, value):
        self._raw.height = value

    cpdef get_width(self):
        return self._raw.width

    cpdef get_height(self):
        return self._raw.height

    @property
    def width(self):
        return self._raw.width

    @width.setter
    def width(self, value):
        self._raw.width = value

    @property
    def height(self):
        return self._raw.height

    @height.setter
    def height(self, value):
        self._raw.height = value

    @property
    def left(self):
        return self._raw.x

    @left.setter
    def left(self, value):
        self._raw.x = value

    @property
    def top(self):
        return self._raw.y

    @top.setter
    def top(self, value):
        self._raw.y = value

    @property
    def right(self):
        return self._raw.x + self._raw.width

    @right.setter
    def right(self, value):
        self._raw.x = value - self._raw.width

    @property
    def bottom(self):
        return self._raw.y + self._raw.height

    @bottom.setter
    def bottom(self, value):
        self._raw.y = value - self._raw.height

    @property
    def centerx(self):
        return self._raw.x + self._raw.width * 0.5

    @centerx.setter
    def centerx(self, value):
        self._raw.x = value - self._raw.width * 0.5

    @property
    def centery(self):
        return self._raw.y + self._raw.height * 0.5

    @centery.setter
    def centery(self, value):
        self._raw.y = value - self._raw.height * 0.5

    @property
    def center(self):
        return Vector2.new(self._raw.x + self._raw.width * 0.5, self._raw.y + self._raw.height * 0.5)

    @center.setter
    def center(self, value):
        cdef double cx, cy
        if isinstance(value, Vector2):
            cx = (<Vector2>value).x
            cy = (<Vector2>value).y
        else:
            cx = value[0]
            cy = value[1]
        self._raw.x = cx - self._raw.width * 0.5
        self._raw.y = cy - self._raw.height * 0.5

    cpdef bint collide_point(self, object point):
        cdef double px, py
        if isinstance(point, Vector2):
            px = (<Vector2>point).x
            py = (<Vector2>point).y
        elif isinstance(point, (tuple, list)):
            if len(point) != 2:
                raise ValueError("Point must be a Vector2, tuple, or list of length 2")
            px = point[0]
            py = point[1]
        else:
            raise ValueError("Point must be a Vector2, tuple, or list of length 2")
        return self._raw.x <= px <= self._raw.x + self._raw.width and \
            self._raw.y <= py <= self._raw.y + self._raw.height

    cpdef bint collide_point_vector2(self, Vector2 point):
        return self._raw.x <= point.x <= self._raw.x + self._raw.width and \
            self._raw.y <= point.y <= self._raw.y + self._raw.height

    cpdef bint collide_point_tuple(self, tuple point):
        return self._raw.x <= point[0] <= self._raw.x + self._raw.width and \
            self._raw.y <= point[1] <= self._raw.y + self._raw.height

    cpdef bint collide_point_list(self, list point):
        return self._raw.x <= point[0] <= self._raw.x + self._raw.width and \
            self._raw.y <= point[1] <= self._raw.y + self._raw.height

    cpdef bint collide_rect(self, object other):
        cdef double ox, oy, sx, sy
        if isinstance(other, Rect):
            ox = (<Rect>other)._raw.x
            oy = (<Rect>other)._raw.y
            sx = (<Rect>other)._raw.width
            sy = (<Rect>other)._raw.height
        elif isinstance(other, Vector4):
            ox = (<Vector4>other).x
            oy = (<Vector4>other).y
            sx = (<Vector4>other).z
            sy = (<Vector4>other).w
        elif isinstance(other, (tuple, list)):
            if len(other) != 4:
                raise ValueError("rect for collision must be a Rect, Vector4, tuple, or list of length 4")
            ox = other[0]
            oy = other[1]
            sx = other[2]
            sy = other[3]
        else:
            raise ValueError("rect for collision must be a Rect, Vector4, tuple, or list of length 4")

        return self._raw.x < ox + sx and \
               ox < self._raw.x + self._raw.width and \
               self._raw.y < oy + sy and \
               oy < self._raw.y + self._raw.height

    cpdef bint collide_rect_vector4(self, Vector4 other):
        return self._raw.x < other.x + other.z and \
               other.x < self._raw.x + self._raw.width and \
               self._raw.y < other.y + other.w and \
               other.y < self._raw.y + self._raw.height

    cpdef bint collide_rect_rect(self, Rect other):
        return self._raw.x < other._raw.x + other._raw.width and \
               other._raw.x < self._raw.x + self._raw.width and \
               self._raw.y < other._raw.y + other._raw.height and \
               other._raw.y < self._raw.y + self._raw.height

    cpdef bint collide_rect_tuple(self, tuple other):
        return self._raw.x < other[0] + other[2] and \
               other[0] < self._raw.x + self._raw.width and \
               self._raw.y < other[1] + other[3] and \
               other[1] < self._raw.y + self._raw.height

    cpdef bint collide_rect_list(self, list other):
        return self._raw.x < other[0] + other[2] and \
               other[0] < self._raw.x + self._raw.width and \
               self._raw.y < other[1] + other[3] and \
               other[1] < self._raw.y + self._raw.height

    cpdef Vector4 get_vector4(self):
        return Vector4.new(self._raw.x, self._raw.y, self._raw.width, self._raw.height)

    cpdef tuple get_tuple(self):
        return (self._raw.x, self._raw.y, self._raw.width, self._raw.height)

    def __repr__(self):
        return f"Rect(position={self._raw.x}, size={self._raw.width})"

    def __getitem__(self, int index):
        if index == 0:
            return self._raw.x
        elif index == 1:
            return self._raw.y
        elif index == 2:
            return self._raw.width
        elif index == 3:
            return self._raw.height
        else:
            raise IndexError("Rect index out of range")

    def __setitem__(self, int index, float value):
        if index == 0:
            self._raw.x = value
        elif index == 1:
            self._raw.y = value
        elif index == 2:
            self._raw.width = value
        elif index == 3:
            self._raw.height = value
        else:
            raise IndexError("Rect index out of range")

    def __len__(self):
        return 4

    def __eq__(self, other):
        if isinstance(other, Rect):
            return self._raw.x == other._raw.x and \
                   self._raw.y == other._raw.y and \
                   self._raw.width == other._raw.width and \
                   self._raw.height == other._raw.height
        return False
