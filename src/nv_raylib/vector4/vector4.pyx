cimport cython
from libc.math cimport sqrt, round
from cpython.list cimport PyList_GET_ITEM
from cpython.tuple cimport PyTuple_GET_ITEM

@cython.freelist(1000)
cdef class Vector4:

    @property
    def x(self):
        return self.data.x

    @x.setter
    def x(self, double value):
        self.data.x = value

    @property
    def y(self):
        return self.data.y

    @y.setter
    def y(self, double value):
        self.data.y = value

    @property
    def z(self):
        return self.data.z

    @z.setter
    def z(self, double value):
        self.data.z = value

    @property
    def w(self):
        return self.data.w

    @w.setter
    def w(self, double value):
        self.data.w = value

    @staticmethod
    cdef inline Vector4 new(double x, double y, double z, double w):
        cdef Vector4 vec = Vector4.__new__(Vector4)
        vec.data.x = x
        vec.data.y = y
        vec.data.z = z
        vec.data.w = w
        return vec

    def __init__(self, *args):
        cdef int nargs = len(args)
        if nargs == 0:
            self.data.x = 0.0
            self.data.y = 0.0
            self.data.z = 0.0
            self.data.w = 0.0
        elif nargs == 1:
            arg = args[0]
            if isinstance(arg, Vector4):
                self.data = (<Vector4>arg).data
            elif hasattr(arg, "clamp_magnitude_ip"):
                self.data.x = arg.x
                self.data.y = arg.y
                self.data.z = arg.z
                self.data.w = arg.w
            elif isinstance(arg, (list, tuple)):
                if len(arg) != 4:
                    raise TypeError(f"Vector4() takes a sequence of length 4, but got {len(arg)}")
                self.data.x = arg[0]
                self.data.y = arg[1]
                self.data.z = arg[2]
                self.data.w = arg[3]
            else:
                raise TypeError(f"Vector4() invalid constructor argument: {type(arg).__name__}")
        elif nargs == 4:
            self.data.x = args[0]
            self.data.y = args[1]
            self.data.z = args[2]
            self.data.w = args[3]
        else:
            raise TypeError(f"Vector4() takes 0, 1, or 4 arguments, but {nargs} were given")

    @staticmethod
    cdef inline Vector4 cfrom_vector4(Vector4 other):
        return Vector4.new(other.data.x, other.data.y, other.data.z, other.data.w)

    @staticmethod
    cdef inline Vector4 cfrom_tuple(tuple other):
        cdef double x, y, z, w
        x = <double><object>PyTuple_GET_ITEM(other, 0)
        y = <double><object>PyTuple_GET_ITEM(other, 1)
        z = <double><object>PyTuple_GET_ITEM(other, 2)
        w = <double><object>PyTuple_GET_ITEM(other, 3)
        return Vector4.new(x, y, z, w)

    @staticmethod
    cdef inline Vector4 cfrom_list(list other):
        cdef double x, y, z, w
        x = <double><object>PyList_GET_ITEM(other, 0)
        y = <double><object>PyList_GET_ITEM(other, 1)
        z = <double><object>PyList_GET_ITEM(other, 2)
        w = <double><object>PyList_GET_ITEM(other, 3)
        return Vector4.new(x, y, z, w)

    @staticmethod
    cdef inline Vector4 cfrom_ints(int x, int y, int z, int w):
        return Vector4.new(x, y, z, w)

    @staticmethod
    cdef inline Vector4 cfrom_floats(float x, float y, float z, float w):
        return Vector4.new(x, y, z, w)

    @staticmethod
    cdef inline Vector4 cfrom_xyzw(double x, double y, double z, double w):
        return Vector4.new(x, y, z, w)

    @staticmethod
    def from_vector4(Vector4 other):
        return Vector4.cfrom_vector4(other)

    @staticmethod
    def from_tuple(tuple other):
        return Vector4.cfrom_tuple(other)

    @staticmethod
    def from_list(list other):
        return Vector4.cfrom_list(other)

    @staticmethod
    def from_ints(int x, int y, int z, int w):
        return Vector4.cfrom_ints(x, y, z, w)

    @staticmethod
    def from_floats(float x, float y, float z, float w):
        return Vector4.cfrom_floats(x, y, z, w)

    @staticmethod
    def from_xyzw(double x, double y, double z, double w):
        return Vector4.cfrom_xyzw(x, y, z, w)

    @property
    def xxxx(self): return Vector4.new(self.data.x, self.data.x, self.data.x, self.data.x)
    @property
    def xxxy(self): return Vector4.new(self.data.x, self.data.x, self.data.x, self.data.y)
    @property
    def xxxz(self): return Vector4.new(self.data.x, self.data.x, self.data.x, self.data.z)
    @property
    def xxxw(self): return Vector4.new(self.data.x, self.data.x, self.data.x, self.data.w)
    @property
    def xxyx(self): return Vector4.new(self.data.x, self.data.x, self.data.y, self.data.x)
    @property
    def xxyy(self): return Vector4.new(self.data.x, self.data.x, self.data.y, self.data.y)
    @property
    def xxyz(self): return Vector4.new(self.data.x, self.data.x, self.data.y, self.data.z)
    @property
    def xxyw(self): return Vector4.new(self.data.x, self.data.x, self.data.y, self.data.w)
    @property
    def xxzx(self): return Vector4.new(self.data.x, self.data.x, self.data.z, self.data.x)
    @property
    def xxzy(self): return Vector4.new(self.data.x, self.data.x, self.data.z, self.data.y)
    @property
    def xxzz(self): return Vector4.new(self.data.x, self.data.x, self.data.z, self.data.z)
    @property
    def xxzw(self): return Vector4.new(self.data.x, self.data.x, self.data.z, self.data.w)
    @property
    def xxwx(self): return Vector4.new(self.data.x, self.data.x, self.data.w, self.data.x)
    @property
    def xxwy(self): return Vector4.new(self.data.x, self.data.x, self.data.w, self.data.y)
    @property
    def xxwz(self): return Vector4.new(self.data.x, self.data.x, self.data.w, self.data.z)
    @property
    def xxww(self): return Vector4.new(self.data.x, self.data.x, self.data.w, self.data.w)
    @property
    def xyxx(self): return Vector4.new(self.data.x, self.data.y, self.data.x, self.data.x)
    @property
    def xyxy(self): return Vector4.new(self.data.x, self.data.y, self.data.x, self.data.y)
    @property
    def xyxz(self): return Vector4.new(self.data.x, self.data.y, self.data.x, self.data.z)
    @property
    def xyxw(self): return Vector4.new(self.data.x, self.data.y, self.data.x, self.data.w)
    @property
    def xyyx(self): return Vector4.new(self.data.x, self.data.y, self.data.y, self.data.x)
    @property
    def xyyy(self): return Vector4.new(self.data.x, self.data.y, self.data.y, self.data.y)
    @property
    def xyyz(self): return Vector4.new(self.data.x, self.data.y, self.data.y, self.data.z)
    @property
    def xyyw(self): return Vector4.new(self.data.x, self.data.y, self.data.y, self.data.w)
    @property
    def xyzx(self): return Vector4.new(self.data.x, self.data.y, self.data.z, self.data.x)
    @property
    def xyzy(self): return Vector4.new(self.data.x, self.data.y, self.data.z, self.data.y)
    @property
    def xyzz(self): return Vector4.new(self.data.x, self.data.y, self.data.z, self.data.z)
    @property
    def xyzw(self): return Vector4.new(self.data.x, self.data.y, self.data.z, self.data.w)
    @property
    def xywx(self): return Vector4.new(self.data.x, self.data.y, self.data.w, self.data.x)
    @property
    def xywy(self): return Vector4.new(self.data.x, self.data.y, self.data.w, self.data.y)
    @property
    def xywz(self): return Vector4.new(self.data.x, self.data.y, self.data.w, self.data.z)
    @property
    def xyww(self): return Vector4.new(self.data.x, self.data.y, self.data.w, self.data.w)
    @property
    def xzxx(self): return Vector4.new(self.data.x, self.data.z, self.data.x, self.data.x)
    @property
    def xzxy(self): return Vector4.new(self.data.x, self.data.z, self.data.x, self.data.y)
    @property
    def xzxz(self): return Vector4.new(self.data.x, self.data.z, self.data.x, self.data.z)
    @property
    def xzxw(self): return Vector4.new(self.data.x, self.data.z, self.data.x, self.data.w)
    @property
    def xzyx(self): return Vector4.new(self.data.x, self.data.z, self.data.y, self.data.x)
    @property
    def xzyy(self): return Vector4.new(self.data.x, self.data.z, self.data.y, self.data.y)
    @property
    def xzyz(self): return Vector4.new(self.data.x, self.data.z, self.data.y, self.data.z)
    @property
    def xzyw(self): return Vector4.new(self.data.x, self.data.z, self.data.y, self.data.w)
    @property
    def xzzx(self): return Vector4.new(self.data.x, self.data.z, self.data.z, self.data.x)
    @property
    def xzzy(self): return Vector4.new(self.data.x, self.data.z, self.data.z, self.data.y)
    @property
    def xzzz(self): return Vector4.new(self.data.x, self.data.z, self.data.z, self.data.z)
    @property
    def xzzw(self): return Vector4.new(self.data.x, self.data.z, self.data.z, self.data.w)
    @property
    def xzwx(self): return Vector4.new(self.data.x, self.data.z, self.data.w, self.data.x)
    @property
    def xzwy(self): return Vector4.new(self.data.x, self.data.z, self.data.w, self.data.y)
    @property
    def xzwz(self): return Vector4.new(self.data.x, self.data.z, self.data.w, self.data.z)
    @property
    def xzww(self): return Vector4.new(self.data.x, self.data.z, self.data.w, self.data.w)
    @property
    def xwxx(self): return Vector4.new(self.data.x, self.data.w, self.data.x, self.data.x)
    @property
    def xwxy(self): return Vector4.new(self.data.x, self.data.w, self.data.x, self.data.y)
    @property
    def xwxz(self): return Vector4.new(self.data.x, self.data.w, self.data.x, self.data.z)
    @property
    def xwxw(self): return Vector4.new(self.data.x, self.data.w, self.data.x, self.data.w)
    @property
    def xwyx(self): return Vector4.new(self.data.x, self.data.w, self.data.y, self.data.x)
    @property
    def xwyy(self): return Vector4.new(self.data.x, self.data.w, self.data.y, self.data.y)
    @property
    def xwyz(self): return Vector4.new(self.data.x, self.data.w, self.data.y, self.data.z)
    @property
    def xwyw(self): return Vector4.new(self.data.x, self.data.w, self.data.y, self.data.w)
    @property
    def xwzx(self): return Vector4.new(self.data.x, self.data.w, self.data.z, self.data.x)
    @property
    def xwzy(self): return Vector4.new(self.data.x, self.data.w, self.data.z, self.data.y)
    @property
    def xwzz(self): return Vector4.new(self.data.x, self.data.w, self.data.z, self.data.z)
    @property
    def xwzw(self): return Vector4.new(self.data.x, self.data.w, self.data.z, self.data.w)
    @property
    def xwwx(self): return Vector4.new(self.data.x, self.data.w, self.data.w, self.data.x)
    @property
    def xwwy(self): return Vector4.new(self.data.x, self.data.w, self.data.w, self.data.y)
    @property
    def xwwz(self): return Vector4.new(self.data.x, self.data.w, self.data.w, self.data.z)
    @property
    def xwww(self): return Vector4.new(self.data.x, self.data.w, self.data.w, self.data.w)

    @property
    def yxxx(self): return Vector4.new(self.data.y, self.data.x, self.data.x, self.data.x)
    @property
    def yxxy(self): return Vector4.new(self.data.y, self.data.x, self.data.x, self.data.y)
    @property
    def yxxz(self): return Vector4.new(self.data.y, self.data.x, self.data.x, self.data.z)
    @property
    def yxxw(self): return Vector4.new(self.data.y, self.data.x, self.data.x, self.data.w)
    @property
    def yxyx(self): return Vector4.new(self.data.y, self.data.x, self.data.y, self.data.x)
    @property
    def yxyy(self): return Vector4.new(self.data.y, self.data.x, self.data.y, self.data.y)
    @property
    def yxyz(self): return Vector4.new(self.data.y, self.data.x, self.data.y, self.data.z)
    @property
    def yxyw(self): return Vector4.new(self.data.y, self.data.x, self.data.y, self.data.w)
    @property
    def yxzx(self): return Vector4.new(self.data.y, self.data.x, self.data.z, self.data.x)
    @property
    def yxzy(self): return Vector4.new(self.data.y, self.data.x, self.data.z, self.data.y)
    @property
    def yxzz(self): return Vector4.new(self.data.y, self.data.x, self.data.z, self.data.z)
    @property
    def yxzw(self): return Vector4.new(self.data.y, self.data.x, self.data.z, self.data.w)
    @property
    def yxwx(self): return Vector4.new(self.data.y, self.data.x, self.data.w, self.data.x)
    @property
    def yxwy(self): return Vector4.new(self.data.y, self.data.x, self.data.w, self.data.y)
    @property
    def yxwz(self): return Vector4.new(self.data.y, self.data.x, self.data.w, self.data.z)
    @property
    def yxww(self): return Vector4.new(self.data.y, self.data.x, self.data.w, self.data.w)
    @property
    def yyxx(self): return Vector4.new(self.data.y, self.data.y, self.data.x, self.data.x)
    @property
    def yyxy(self): return Vector4.new(self.data.y, self.data.y, self.data.x, self.data.y)
    @property
    def yyxz(self): return Vector4.new(self.data.y, self.data.y, self.data.x, self.data.z)
    @property
    def yyxw(self): return Vector4.new(self.data.y, self.data.y, self.data.x, self.data.w)
    @property
    def yyyx(self): return Vector4.new(self.data.y, self.data.y, self.data.y, self.data.x)
    @property
    def yyyy(self): return Vector4.new(self.data.y, self.data.y, self.data.y, self.data.y)
    @property
    def yyyz(self): return Vector4.new(self.data.y, self.data.y, self.data.y, self.data.z)
    @property
    def yyyw(self): return Vector4.new(self.data.y, self.data.y, self.data.y, self.data.w)
    @property
    def yyzx(self): return Vector4.new(self.data.y, self.data.y, self.data.z, self.data.x)
    @property
    def yyzy(self): return Vector4.new(self.data.y, self.data.y, self.data.z, self.data.y)
    @property
    def yyzz(self): return Vector4.new(self.data.y, self.data.y, self.data.z, self.data.z)
    @property
    def yyzw(self): return Vector4.new(self.data.y, self.data.y, self.data.z, self.data.w)
    @property
    def yywx(self): return Vector4.new(self.data.y, self.data.y, self.data.w, self.data.x)
    @property
    def yywy(self): return Vector4.new(self.data.y, self.data.y, self.data.w, self.data.y)
    @property
    def yywz(self): return Vector4.new(self.data.y, self.data.y, self.data.w, self.data.z)
    @property
    def yyww(self): return Vector4.new(self.data.y, self.data.y, self.data.w, self.data.w)
    @property
    def yzxx(self): return Vector4.new(self.data.y, self.data.z, self.data.x, self.data.x)
    @property
    def yzxy(self): return Vector4.new(self.data.y, self.data.z, self.data.x, self.data.y)
    @property
    def yzxz(self): return Vector4.new(self.data.y, self.data.z, self.data.x, self.data.z)
    @property
    def yzxw(self): return Vector4.new(self.data.y, self.data.z, self.data.x, self.data.w)
    @property
    def yzyx(self): return Vector4.new(self.data.y, self.data.z, self.data.y, self.data.x)
    @property
    def yzyy(self): return Vector4.new(self.data.y, self.data.z, self.data.y, self.data.y)
    @property
    def yzyz(self): return Vector4.new(self.data.y, self.data.z, self.data.y, self.data.z)
    @property
    def yzyw(self): return Vector4.new(self.data.y, self.data.z, self.data.y, self.data.w)
    @property
    def yzzx(self): return Vector4.new(self.data.y, self.data.z, self.data.z, self.data.x)
    @property
    def yzzy(self): return Vector4.new(self.data.y, self.data.z, self.data.z, self.data.y)
    @property
    def yzzz(self): return Vector4.new(self.data.y, self.data.z, self.data.z, self.data.z)
    @property
    def yzzw(self): return Vector4.new(self.data.y, self.data.z, self.data.z, self.data.w)
    @property
    def yzwx(self): return Vector4.new(self.data.y, self.data.z, self.data.w, self.data.x)
    @property
    def yzwy(self): return Vector4.new(self.data.y, self.data.z, self.data.w, self.data.y)
    @property
    def yzwz(self): return Vector4.new(self.data.y, self.data.z, self.data.w, self.data.z)
    @property
    def yzww(self): return Vector4.new(self.data.y, self.data.z, self.data.w, self.data.w)
    @property
    def ywxx(self): return Vector4.new(self.data.y, self.data.w, self.data.x, self.data.x)
    @property
    def ywxy(self): return Vector4.new(self.data.y, self.data.w, self.data.x, self.data.y)
    @property
    def ywxz(self): return Vector4.new(self.data.y, self.data.w, self.data.x, self.data.z)
    @property
    def ywxw(self): return Vector4.new(self.data.y, self.data.w, self.data.x, self.data.w)
    @property
    def ywyx(self): return Vector4.new(self.data.y, self.data.w, self.data.y, self.data.x)
    @property
    def ywyy(self): return Vector4.new(self.data.y, self.data.w, self.data.y, self.data.y)
    @property
    def ywyz(self): return Vector4.new(self.data.y, self.data.w, self.data.y, self.data.z)
    @property
    def ywyw(self): return Vector4.new(self.data.y, self.data.w, self.data.y, self.data.w)
    @property
    def ywzx(self): return Vector4.new(self.data.y, self.data.w, self.data.z, self.data.x)
    @property
    def ywzy(self): return Vector4.new(self.data.y, self.data.w, self.data.z, self.data.y)
    @property
    def ywzz(self): return Vector4.new(self.data.y, self.data.w, self.data.z, self.data.z)
    @property
    def ywzw(self): return Vector4.new(self.data.y, self.data.w, self.data.z, self.data.w)
    @property
    def ywwx(self): return Vector4.new(self.data.y, self.data.w, self.data.w, self.data.x)
    @property
    def ywwy(self): return Vector4.new(self.data.y, self.data.w, self.data.w, self.data.y)
    @property
    def ywwz(self): return Vector4.new(self.data.y, self.data.w, self.data.w, self.data.z)
    @property
    def ywww(self): return Vector4.new(self.data.y, self.data.w, self.data.w, self.data.w)

    @property
    def zxxx(self): return Vector4.new(self.data.z, self.data.x, self.data.x, self.data.x)
    @property
    def zxxy(self): return Vector4.new(self.data.z, self.data.x, self.data.x, self.data.y)
    @property
    def zxxz(self): return Vector4.new(self.data.z, self.data.x, self.data.x, self.data.z)
    @property
    def zxxw(self): return Vector4.new(self.data.z, self.data.x, self.data.x, self.data.w)
    @property
    def zxyx(self): return Vector4.new(self.data.z, self.data.x, self.data.y, self.data.x)
    @property
    def zxyy(self): return Vector4.new(self.data.z, self.data.x, self.data.y, self.data.y)
    @property
    def zxyz(self): return Vector4.new(self.data.z, self.data.x, self.data.y, self.data.z)
    @property
    def zxyw(self): return Vector4.new(self.data.z, self.data.x, self.data.y, self.data.w)
    @property
    def zxzx(self): return Vector4.new(self.data.z, self.data.x, self.data.z, self.data.x)
    @property
    def zxzy(self): return Vector4.new(self.data.z, self.data.x, self.data.z, self.data.y)
    @property
    def zxzz(self): return Vector4.new(self.data.z, self.data.x, self.data.z, self.data.z)
    @property
    def zxzw(self): return Vector4.new(self.data.z, self.data.x, self.data.z, self.data.w)
    @property
    def zxwx(self): return Vector4.new(self.data.z, self.data.x, self.data.w, self.data.x)
    @property
    def zxwy(self): return Vector4.new(self.data.z, self.data.x, self.data.w, self.data.y)
    @property
    def zxwz(self): return Vector4.new(self.data.z, self.data.x, self.data.w, self.data.z)
    @property
    def zxww(self): return Vector4.new(self.data.z, self.data.x, self.data.w, self.data.w)
    @property
    def zyxx(self): return Vector4.new(self.data.z, self.data.y, self.data.x, self.data.x)
    @property
    def zyxy(self): return Vector4.new(self.data.z, self.data.y, self.data.x, self.data.y)
    @property
    def zyxz(self): return Vector4.new(self.data.z, self.data.y, self.data.x, self.data.z)
    @property
    def zyxw(self): return Vector4.new(self.data.z, self.data.y, self.data.x, self.data.w)
    @property
    def zyyx(self): return Vector4.new(self.data.z, self.data.y, self.data.y, self.data.x)
    @property
    def zyyy(self): return Vector4.new(self.data.z, self.data.y, self.data.y, self.data.y)
    @property
    def zyyz(self): return Vector4.new(self.data.z, self.data.y, self.data.y, self.data.z)
    @property
    def zyyw(self): return Vector4.new(self.data.z, self.data.y, self.data.y, self.data.w)
    @property
    def zyzx(self): return Vector4.new(self.data.z, self.data.y, self.data.z, self.data.x)
    @property
    def zyzy(self): return Vector4.new(self.data.z, self.data.y, self.data.z, self.data.y)
    @property
    def zyzz(self): return Vector4.new(self.data.z, self.data.y, self.data.z, self.data.z)
    @property
    def zyzw(self): return Vector4.new(self.data.z, self.data.y, self.data.z, self.data.w)
    @property
    def zywx(self): return Vector4.new(self.data.z, self.data.y, self.data.w, self.data.x)
    @property
    def zywy(self): return Vector4.new(self.data.z, self.data.y, self.data.w, self.data.y)
    @property
    def zywz(self): return Vector4.new(self.data.z, self.data.y, self.data.w, self.data.z)
    @property
    def zyww(self): return Vector4.new(self.data.z, self.data.y, self.data.w, self.data.w)
    @property
    def zzxx(self): return Vector4.new(self.data.z, self.data.z, self.data.x, self.data.x)
    @property
    def zzxy(self): return Vector4.new(self.data.z, self.data.z, self.data.x, self.data.y)
    @property
    def zzxz(self): return Vector4.new(self.data.z, self.data.z, self.data.x, self.data.z)
    @property
    def zzxw(self): return Vector4.new(self.data.z, self.data.z, self.data.x, self.data.w)
    @property
    def zzyx(self): return Vector4.new(self.data.z, self.data.z, self.data.y, self.data.x)
    @property
    def zzyy(self): return Vector4.new(self.data.z, self.data.z, self.data.y, self.data.y)
    @property
    def zzyz(self): return Vector4.new(self.data.z, self.data.z, self.data.y, self.data.z)
    @property
    def zzyw(self): return Vector4.new(self.data.z, self.data.z, self.data.y, self.data.w)
    @property
    def zzzx(self): return Vector4.new(self.data.z, self.data.z, self.data.z, self.data.x)
    @property
    def zzzy(self): return Vector4.new(self.data.z, self.data.z, self.data.z, self.data.y)
    @property
    def zzzz(self): return Vector4.new(self.data.z, self.data.z, self.data.z, self.data.z)
    @property
    def zzzw(self): return Vector4.new(self.data.z, self.data.z, self.data.z, self.data.w)
    @property
    def zzwx(self): return Vector4.new(self.data.z, self.data.z, self.data.w, self.data.x)
    @property
    def zzwy(self): return Vector4.new(self.data.z, self.data.z, self.data.w, self.data.y)
    @property
    def zzwz(self): return Vector4.new(self.data.z, self.data.z, self.data.w, self.data.z)
    @property
    def zzww(self): return Vector4.new(self.data.z, self.data.z, self.data.w, self.data.w)
    @property
    def zwxx(self): return Vector4.new(self.data.z, self.data.w, self.data.x, self.data.x)
    @property
    def zwxy(self): return Vector4.new(self.data.z, self.data.w, self.data.x, self.data.y)
    @property
    def zwxz(self): return Vector4.new(self.data.z, self.data.w, self.data.x, self.data.z)
    @property
    def zwxw(self): return Vector4.new(self.data.z, self.data.w, self.data.x, self.data.w)
    @property
    def zwyx(self): return Vector4.new(self.data.z, self.data.w, self.data.y, self.data.x)
    @property
    def zwyy(self): return Vector4.new(self.data.z, self.data.w, self.data.y, self.data.y)
    @property
    def zwyz(self): return Vector4.new(self.data.z, self.data.w, self.data.y, self.data.z)
    @property
    def zwyw(self): return Vector4.new(self.data.z, self.data.w, self.data.y, self.data.w)
    @property
    def zwzx(self): return Vector4.new(self.data.z, self.data.w, self.data.z, self.data.x)
    @property
    def zwzy(self): return Vector4.new(self.data.z, self.data.w, self.data.z, self.data.y)
    @property
    def zwzz(self): return Vector4.new(self.data.z, self.data.w, self.data.z, self.data.z)
    @property
    def zwzw(self): return Vector4.new(self.data.z, self.data.w, self.data.z, self.data.w)
    @property
    def zwwx(self): return Vector4.new(self.data.z, self.data.w, self.data.w, self.data.x)
    @property
    def zwwy(self): return Vector4.new(self.data.z, self.data.w, self.data.w, self.data.y)
    @property
    def zwwz(self): return Vector4.new(self.data.z, self.data.w, self.data.w, self.data.z)
    @property
    def zwww(self): return Vector4.new(self.data.z, self.data.w, self.data.w, self.data.w)

    @property
    def wxxx(self): return Vector4.new(self.data.w, self.data.x, self.data.x, self.data.x)
    @property
    def wxxy(self): return Vector4.new(self.data.w, self.data.x, self.data.x, self.data.y)
    @property
    def wxxz(self): return Vector4.new(self.data.w, self.data.x, self.data.x, self.data.z)
    @property
    def wxxw(self): return Vector4.new(self.data.w, self.data.x, self.data.x, self.data.w)
    @property
    def wxyx(self): return Vector4.new(self.data.w, self.data.x, self.data.y, self.data.x)
    @property
    def wxyy(self): return Vector4.new(self.data.w, self.data.x, self.data.y, self.data.y)
    @property
    def wxyz(self): return Vector4.new(self.data.w, self.data.x, self.data.y, self.data.z)
    @property
    def wxyw(self): return Vector4.new(self.data.w, self.data.x, self.data.y, self.data.w)
    @property
    def wxzx(self): return Vector4.new(self.data.w, self.data.x, self.data.z, self.data.x)
    @property
    def wxzy(self): return Vector4.new(self.data.w, self.data.x, self.data.z, self.data.y)
    @property
    def wxzz(self): return Vector4.new(self.data.w, self.data.x, self.data.z, self.data.z)
    @property
    def wxzw(self): return Vector4.new(self.data.w, self.data.x, self.data.z, self.data.w)
    @property
    def wxwx(self): return Vector4.new(self.data.w, self.data.x, self.data.w, self.data.x)
    @property
    def wxwy(self): return Vector4.new(self.data.w, self.data.x, self.data.w, self.data.y)
    @property
    def wxwz(self): return Vector4.new(self.data.w, self.data.x, self.data.w, self.data.z)
    @property
    def wxww(self): return Vector4.new(self.data.w, self.data.x, self.data.w, self.data.w)
    @property
    def wyxx(self): return Vector4.new(self.data.w, self.data.y, self.data.x, self.data.x)
    @property
    def wyxy(self): return Vector4.new(self.data.w, self.data.y, self.data.x, self.data.y)
    @property
    def wyxz(self): return Vector4.new(self.data.w, self.data.y, self.data.x, self.data.z)
    @property
    def wyxw(self): return Vector4.new(self.data.w, self.data.y, self.data.x, self.data.w)
    @property
    def wyyx(self): return Vector4.new(self.data.w, self.data.y, self.data.y, self.data.x)
    @property
    def wyyy(self): return Vector4.new(self.data.w, self.data.y, self.data.y, self.data.y)
    @property
    def wyyz(self): return Vector4.new(self.data.w, self.data.y, self.data.y, self.data.z)
    @property
    def wyyw(self): return Vector4.new(self.data.w, self.data.y, self.data.y, self.data.w)
    @property
    def wyzx(self): return Vector4.new(self.data.w, self.data.y, self.data.z, self.data.x)
    @property
    def wyzy(self): return Vector4.new(self.data.w, self.data.y, self.data.z, self.data.y)
    @property
    def wyzz(self): return Vector4.new(self.data.w, self.data.y, self.data.z, self.data.z)
    @property
    def wyzw(self): return Vector4.new(self.data.w, self.data.y, self.data.z, self.data.w)
    @property
    def wywx(self): return Vector4.new(self.data.w, self.data.y, self.data.w, self.data.x)
    @property
    def wywy(self): return Vector4.new(self.data.w, self.data.y, self.data.w, self.data.y)
    @property
    def wywz(self): return Vector4.new(self.data.w, self.data.y, self.data.w, self.data.z)
    @property
    def wyww(self): return Vector4.new(self.data.w, self.data.y, self.data.w, self.data.w)
    @property
    def wzxx(self): return Vector4.new(self.data.w, self.data.z, self.data.x, self.data.x)
    @property
    def wzxy(self): return Vector4.new(self.data.w, self.data.z, self.data.x, self.data.y)
    @property
    def wzxz(self): return Vector4.new(self.data.w, self.data.z, self.data.x, self.data.z)
    @property
    def wzxw(self): return Vector4.new(self.data.w, self.data.z, self.data.x, self.data.w)
    @property
    def wzyx(self): return Vector4.new(self.data.w, self.data.z, self.data.y, self.data.x)
    @property
    def wzyy(self): return Vector4.new(self.data.w, self.data.z, self.data.y, self.data.y)
    @property
    def wzyz(self): return Vector4.new(self.data.w, self.data.z, self.data.y, self.data.z)
    @property
    def wzyw(self): return Vector4.new(self.data.w, self.data.z, self.data.y, self.data.w)
    @property
    def wzzx(self): return Vector4.new(self.data.w, self.data.z, self.data.z, self.data.x)
    @property
    def wzzy(self): return Vector4.new(self.data.w, self.data.z, self.data.z, self.data.y)
    @property
    def wzzz(self): return Vector4.new(self.data.w, self.data.z, self.data.z, self.data.z)
    @property
    def wzzw(self): return Vector4.new(self.data.w, self.data.z, self.data.z, self.data.w)
    @property
    def wzwx(self): return Vector4.new(self.data.w, self.data.z, self.data.w, self.data.x)
    @property
    def wzwy(self): return Vector4.new(self.data.w, self.data.z, self.data.w, self.data.y)
    @property
    def wzwz(self): return Vector4.new(self.data.w, self.data.z, self.data.w, self.data.z)
    @property
    def wzww(self): return Vector4.new(self.data.w, self.data.z, self.data.w, self.data.w)
    @property
    def wwxx(self): return Vector4.new(self.data.w, self.data.w, self.data.x, self.data.x)
    @property
    def wwxy(self): return Vector4.new(self.data.w, self.data.w, self.data.x, self.data.y)
    @property
    def wwxz(self): return Vector4.new(self.data.w, self.data.w, self.data.x, self.data.z)
    @property
    def wwxw(self): return Vector4.new(self.data.w, self.data.w, self.data.x, self.data.w)
    @property
    def wwyx(self): return Vector4.new(self.data.w, self.data.w, self.data.y, self.data.x)
    @property
    def wwyy(self): return Vector4.new(self.data.w, self.data.w, self.data.y, self.data.y)
    @property
    def wwyz(self): return Vector4.new(self.data.w, self.data.w, self.data.y, self.data.z)
    @property
    def wwyw(self): return Vector4.new(self.data.w, self.data.w, self.data.y, self.data.w)
    @property
    def wwzx(self): return Vector4.new(self.data.w, self.data.w, self.data.z, self.data.x)
    @property
    def wwzy(self): return Vector4.new(self.data.w, self.data.w, self.data.z, self.data.y)
    @property
    def wwzz(self): return Vector4.new(self.data.w, self.data.w, self.data.z, self.data.z)
    @property
    def wwzw(self): return Vector4.new(self.data.w, self.data.w, self.data.z, self.data.w)
    @property
    def wwwx(self): return Vector4.new(self.data.w, self.data.w, self.data.w, self.data.x)
    @property
    def wwwy(self): return Vector4.new(self.data.w, self.data.w, self.data.w, self.data.y)
    @property
    def wwwz(self): return Vector4.new(self.data.w, self.data.w, self.data.w, self.data.z)
    @property
    def wwww(self): return Vector4.new(self.data.w, self.data.w, self.data.w, self.data.w)

    def __getitem__(self, int index):
        cdef vector4_t data = self.data
        if index == 0:
            return data.x
        elif index == 1:
            return data.y
        elif index == 2:
            return data.z
        elif index == 3:
            return data.w
        else:
            raise IndexError("Vector index out of range")

    def __setitem__(self, int index, double value):
        if index == 0:
            self.data.x = value
        elif index == 1:
            self.data.y = value
        elif index == 2:
            self.data.z = value
        elif index == 3:
            self.data.w = value
        else:
            raise IndexError("Vector index out of range")

    def __add__(self, Vector4 other):
        cdef vector4_t res = vector4_add(self.data, other.data)
        return Vector4.new(res.x, res.y, res.z, res.w)

    def __sub__(self, Vector4 other):
        cdef vector4_t res = vector4_sub(self.data, other.data)
        return Vector4.new(res.x, res.y, res.z, res.w)

    def __mul__(self, other):
        cdef vector4_t res
        if isinstance(other, Vector4):
            res = vector4_mul_vector(self.data, (<Vector4>other).data)
            return Vector4.new(res.x, res.y, res.z, res.w)
        elif isinstance(other, (int, float)):
            res = vector4_mul_scalar(self.data, other)
            return Vector4.new(res.x, res.y, res.z, res.w)
        return NotImplemented

    def __truediv__(self, other):
        cdef vector4_t res
        if isinstance(other, Vector4):
            res = vector4_div_vector(self.data, (<Vector4>other).data)
            return Vector4.new(res.x, res.y, res.z, res.w)
        elif isinstance(other, (int, float)):
            res = vector4_div_scalar(self.data, other)
            return Vector4.new(res.x, res.y, res.z, res.w)
        return NotImplemented

    def __floordiv__(self, other):
        cdef vector4_t res
        if isinstance(other, Vector4):
            res = vector4_floordiv_vector(self.data, (<Vector4>other).data)
            return Vector4.new(res.x, res.y, res.z, res.w)
        elif isinstance(other, (int, float)):
            res = vector4_floordiv_scalar(self.data, other)
            return Vector4.new(res.x, res.y, res.z, res.w)
        return NotImplemented

    def __iadd__(self, Vector4 other):
        vector4_iadd(&self.data, other.data)
        return self

    def __isub__(self, Vector4 other):
        vector4_isub(&self.data, other.data)
        return self

    def __imul__(self, Vector4 other):
        vector4_imul(&self.data, other.data)
        return self

    def __neg__(self):
        return self.get_neg()

    def __repr__(self):
        return f"Vector4({self.data.x}, {self.data.y}, {self.data.z}, {self.data.w})"

    def __copy__(self):
        cdef vector4_t data = self.data
        return Vector4.new(data.x, data.y, data.z, data.w)

    def __deepcopy__(self, memo):
        cdef vector4_t data = self.data
        return Vector4.new(data.x, data.y, data.z, data.w)

    def __hash__(self):
        cdef vector4_t data = self.data
        return hash((data.x, data.y, data.z, data.w))

    def __len__(self):
        return 4

    def __eq__(self, other):
        cdef vector4_t other_data
        if isinstance(other, Vector4):
            other_data = (<Vector4>other).data
            return self.data.x == other_data.x and self.data.y == other_data.y and self.data.z == other_data.z and self.data.w == other_data.w
        return False

    cdef inline Vector4 _add(self, Vector4 other):
        cdef vector4_t res = vector4_add(self.data, other.data)
        return Vector4.new(res.x, res.y, res.z, res.w)

    cdef inline Vector4 _sub(self, Vector4 other):
        cdef vector4_t res = vector4_sub(self.data, other.data)
        return Vector4.new(res.x, res.y, res.z, res.w)

    cdef inline void _iadd(self, Vector4 other) nogil:
        vector4_iadd(&self.data, other.data)

    cdef inline void _sadd(self, Vector4 new_vec, Vector4 old_vec) nogil:
        self.data.x = new_vec.data.x + old_vec.data.x
        self.data.y = new_vec.data.y + old_vec.data.y
        self.data.z = new_vec.data.z + old_vec.data.z
        self.data.w = new_vec.data.w + old_vec.data.w

    cdef inline void _isub(self, Vector4 other) nogil:
        vector4_isub(&self.data, other.data)

    cdef inline void _imul(self, Vector4 other) nogil:
        vector4_imul(&self.data, other.data)

    cpdef void sadd(self, Vector4 new_vec, Vector4 old_vec):
        self._sadd(new_vec, old_vec)

    cpdef tuple get_tuple(self):
        return self.c_get_tuple()

    cdef inline tuple c_get_tuple(self):
        cdef vector4_t data = self.data
        return (data.x, data.y, data.z, data.w)

    cpdef Vector4 to_round(self):
        cdef vector4_t data = self.data
        self.data.x = round(data.x)
        self.data.y = round(data.y)
        self.data.z = round(data.z)
        self.data.w = round(data.w)
        return self

    cpdef Vector4 get_round(self):
        cdef vector4_t data = self.data
        return Vector4.new(round(data.x), round(data.y), round(data.z), round(data.w))

    cpdef Vector4 to_abs(self):
        cdef vector4_t data = self.data
        self.data.x = abs(data.x)
        self.data.y = abs(data.y)
        self.data.z = abs(data.z)
        self.data.w = abs(data.w)
        return self

    cpdef Vector4 get_abs(self):
        cdef vector4_t data = self.data
        return Vector4.new(abs(data.x), abs(data.y), abs(data.z), abs(data.w))

    cpdef Vector4 to_neg(self):
        cdef vector4_t data = self.data
        self.data.x = -data.x
        self.data.y = -data.y
        self.data.z = -data.z
        self.data.w = -data.w
        return self

    cpdef Vector4 get_neg(self):
        cdef vector4_t data = self.data
        return Vector4.new(-data.x, -data.y, -data.z, -data.w)

    cpdef tuple get_int_tuple(self):
        cdef vector4_t data = self.data
        return (<int>data.x, <int>data.y, <int>data.z, <int>data.w)

    cpdef tuple get_rounded_tuple(self):
        cdef vector4_t data = self.data
        return (<int>round(data.x), <int>round(data.y), <int>round(data.z), <int>round(data.w))

    cpdef Vector4 copy(self):
        cdef vector4_t data = self.data
        return Vector4.new(data.x, data.y, data.z, data.w)

    @property
    def length(self):
        return vector4_length(self.data)

    cpdef Vector4 to_normalized(self):
        self.data = vector4_normalize(self.data)
        return self

    cpdef Vector4 get_normalized(self):
        cdef vector4_t res = vector4_normalize(self.data)
        return Vector4.new(res.x, res.y, res.z, res.w)

    cpdef double distance_to(self, Vector4 other):
        return vector4_distance_to(self.data, other.data)

    cpdef double distance_squared_to(self, Vector4 other):
        return vector4_distance_squared_to(self.data, other.data)

    cpdef double dot(self, Vector4 other):
        return vector4_dot(self.data, other.data)
