from nv_raylib.vector2.vector2 cimport Vector2
from nv_raylib.vector4.vector4 cimport Vector4

cdef class Rect:
    @staticmethod
    cdef inline Rect new(Vector2 position, Vector2 size):
        cdef Rect rect = Rect.__new__(Rect)
        rect.position = position
        rect.size = size
        return rect

    def __init__(self, *args):
        cdef int nargs = len(args)
        cdef object arg_0, arg_1, arg_2, arg_3
        if nargs == 0:
            self.position = Vector2.new(0, 0)
            self.size = Vector2.new(0, 0)
        elif nargs == 1:
            arg_0 = args[0]
            if isinstance(arg_0, Vector2):
                self.position = Vector2.new(0, 0)
                self.size = arg_0
            elif isinstance(arg_0, Rect):
                self.position = (<Rect>arg_0).position
                self.size = (<Rect>arg_0).size
            elif isinstance(arg_0, Vector4):
                self.position = Vector2.new((<Vector4>arg_0).x, (<Vector4>arg_0).y)
                self.size = Vector2.new((<Vector4>arg_0).z, (<Vector4>arg_0).w)
            elif isinstance(arg_0, (tuple, list)):
                if len(arg_0) != 4:
                    raise ValueError("list/tuple for rect must have 4 elements")
                self.position = Vector2.new(arg_0[0], arg_0[1])
                self.size = Vector2.new(arg_0[2], arg_0[3])
            else:
                raise ValueError("Rect takes Vector2, Rect, Vector4, or list/tuple of length 4")
        elif nargs == 2:
            arg_0 = args[0]
            arg_1 = args[1]
            if isinstance(arg_0, Vector2):
                self.position = arg_0
            elif isinstance(arg_0, (list, tuple)) and len(arg_0) == 2:
                self.position = Vector2.new(arg_0[0], arg_0[1])
            else:
                raise ValueError("First argument must be a Vector2 or list/tuple of length 2")
            if isinstance(arg_1, Vector2):
                self.size = arg_1
            elif isinstance(arg_1, (list, tuple)) and len(arg_1) == 2:
                self.size = Vector2.new(arg_1[0], arg_1[1])
            else:
                raise ValueError("Second argument must be a Vector2 or list/tuple of length 2")
        elif nargs == 4:
            self.position = Vector2.new(args[0], args[1])
            self.size = Vector2.new(args[2], args[3])
        else:
            raise TypeError(f"Rect expected 0, 1, 2, or 4 arguments, got {nargs}")

    @property
    def x(self):
        return self.position.x

    @x.setter
    def x(self, value):
        self.position.x = value

    @property
    def y(self):
        return self.position.y

    @y.setter
    def y(self, value):
        self.position.y = value

    @property
    def w(self):
        return self.size.x

    @w.setter
    def w(self, value):
        self.size.x = value

    @property
    def h(self):
        return self.size.y

    @h.setter
    def h(self, value):
        self.size.y = value

    cpdef get_width(self):
        return self.size.x

    cpdef get_height(self):
        return self.size.y

    @property
    def width(self):
        return self.size.x

    @width.setter
    def width(self, value):
        self.size.x = value

    @property
    def height(self):
        return self.size.y

    @height.setter
    def height(self, value):
        self.size.y = value

    @property
    def left(self):
        return self.position.x

    @left.setter
    def left(self, value):
        self.position.x = value

    @property
    def top(self):
        return self.position.y

    @top.setter
    def top(self, value):
        self.position.y = value

    @property
    def right(self):
        return self.position.x + self.size.x

    @right.setter
    def right(self, value):
        self.position.x = value - self.size.x

    @property
    def bottom(self):
        return self.position.y + self.size.y

    @bottom.setter
    def bottom(self, value):
        self.position.y = value - self.size.y

    @property
    def centerx(self):
        return self.position.x + self.size.x * 0.5

    @centerx.setter
    def centerx(self, value):
        self.position.x = value - self.size.x * 0.5

    @property
    def centery(self):
        return self.position.y + self.size.y * 0.5

    @centery.setter
    def centery(self, value):
        self.position.y = value - self.size.y * 0.5

    @property
    def center(self):
        return Vector2.new(self.position.x + self.size.x * 0.5, self.position.y + self.size.y * 0.5)

    @center.setter
    def center(self, value):
        cdef double cx, cy
        if isinstance(value, Vector2):
            cx = (<Vector2>value).x
            cy = (<Vector2>value).y
        else:
            cx = value[0]
            cy = value[1]
        self.position.x = cx - self.size.x * 0.5
        self.position.y = cy - self.size.y * 0.5

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
        return self.position.x <= px <= self.position.x + self.size.x and \
            self.position.y <= py <= self.position.y + self.size.y

    cpdef bint collide_point_vector2(self, Vector2 point):
        return self.position.x <= point.x <= self.position.x + self.size.x and \
            self.position.y <= point.y <= self.position.y + self.size.y

    cpdef bint collide_point_tuple(self, tuple point):
        return self.position.x <= point[0] <= self.position.x + self.size.x and \
            self.position.y <= point[1] <= self.position.y + self.size.y

    cpdef bint collide_point_list(self, list point):
        return self.position.x <= point[0] <= self.position.x + self.size.x and \
            self.position.y <= point[1] <= self.position.y + self.size.y

    cpdef bint collide_rect(self, object other):
        cdef double ox, oy, sx, sy
        if isinstance(other, Rect):
            ox = (<Rect>other).position.x
            oy = (<Rect>other).position.y
            sx = (<Rect>other).size.x
            sy = (<Rect>other).size.y
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

        return self.position.x < ox + sx and \
               ox < self.position.x + self.size.x and \
               self.position.y < oy + sy and \
               oy < self.position.y + self.size.y

    cpdef bint collide_rect_vector4(self, Vector4 other):
        return self.position.x < other.x + other.z and \
               other.x < self.position.x + self.size.x and \
               self.position.y < other.y + other.w and \
               other.y < self.position.y + self.size.y

    cpdef bint collide_rect_rect(self, Rect other):
        return self.position.x < other.position.x + other.size.x and \
               other.position.x < self.position.x + self.size.x and \
               self.position.y < other.position.y + other.size.y and \
               other.position.y < self.position.y + self.size.y

    cpdef bint collide_rect_tuple(self, tuple other):
        return self.position.x < other[0] + other[2] and \
               other[0] < self.position.x + self.size.x and \
               self.position.y < other[1] + other[3] and \
               other[1] < self.position.y + self.size.y

    cpdef bint collide_rect_list(self, list other):
        return self.position.x < other[0] + other[2] and \
               other[0] < self.position.x + self.size.x and \
               self.position.y < other[1] + other[3] and \
               other[1] < self.position.y + self.size.y

    cpdef Vector4 get_vector4(self):
        return Vector4.new(self.position.x, self.position.y, self.size.x, self.size.y)

    cpdef tuple get_tuple(self):
        return (self.position.x, self.position.y, self.size.x, self.size.y)

    def __repr__(self):
        return f"Rect(position={self.position}, size={self.size})"

    def __getitem__(self, int index):
        if index == 0:
            return self.position.x
        elif index == 1:
            return self.position.y
        elif index == 2:
            return self.size.x
        elif index == 3:
            return self.size.y
        else:
            raise IndexError("Rect index out of range")

    def __setitem__(self, int index, float value):
        if index == 0:
            self.position.x = value
        elif index == 1:
            self.position.y = value
        elif index == 2:
            self.size.x = value
        elif index == 3:
            self.size.y = value
        else:
            raise IndexError("Rect index out of range")

    def __len__(self):
        return 4

    def __eq__(self, other):
        if isinstance(other, Rect):
            return self.position.x == other.position.x and \
                   self.position.y == other.position.y and \
                   self.size.x == other.size.x and \
                   self.size.y == other.size.y
        return False
