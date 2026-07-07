cimport cython
from libc.math cimport sqrt, round
from cpython.list cimport PyList_GET_ITEM
from cpython.tuple cimport PyTuple_GET_ITEM

@cython.freelist(1000)
@cython.final
cdef class Vector3:

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

    @staticmethod
    cdef inline Vector3 new(double x, double y, double z):
        cdef Vector3 vec = Vector3.__new__(Vector3)
        vec.data.x = x
        vec.data.y = y
        vec.data.z = z
        return vec

    def __init__(self, *args):
        cdef int nargs = len(args)
        if nargs == 0:
            self.data.x = 0.0
            self.data.y = 0.0
            self.data.z = 0.0
        elif nargs == 1:
            arg = args[0]
            if isinstance(arg, Vector3):
                self.data = (<Vector3>arg).data
            elif hasattr(arg, "clamp_magnitude_ip"):
                self.data.x = arg.x
                self.data.y = arg.y
                self.data.z = arg.z
            elif isinstance(arg, (list, tuple)):
                if len(arg) != 3:
                    raise TypeError(f"Vector3() takes a sequence of length 3, but got {len(arg)}")
                self.data.x = arg[0]
                self.data.y = arg[1]
                self.data.z = arg[2]
            else:
                raise TypeError(f"Vector3() invalid constructor argument: {type(arg).__name__}")
        elif nargs == 3:
            self.data.x = args[0]
            self.data.y = args[1]
            self.data.z = args[2]
        else:
            raise TypeError(f"Vector3() takes 0, 1, or 3 arguments, but {nargs} were given")

    @staticmethod
    cdef inline Vector3 cfrom_vector3(Vector3 other):
        return Vector3.new(other.data.x, other.data.y, other.data.z)

    @staticmethod
    cdef inline Vector3 cfrom_tuple(tuple other):
        cdef double x, y, z
        x = <double><object>PyTuple_GET_ITEM(other, 0)
        y = <double><object>PyTuple_GET_ITEM(other, 1)
        z = <double><object>PyTuple_GET_ITEM(other, 2)
        return Vector3.new(x, y, z)

    @staticmethod
    cdef inline Vector3 cfrom_list(list other):
        cdef double x, y, z
        x = <double><object>PyList_GET_ITEM(other, 0)
        y = <double><object>PyList_GET_ITEM(other, 1)
        z = <double><object>PyList_GET_ITEM(other, 2)
        return Vector3.new(x, y, z)

    @staticmethod
    cdef inline Vector3 cfrom_ints(int x, int y, int z):
        return Vector3.new(x, y, z)

    @staticmethod
    cdef inline Vector3 cfrom_floats(float x, float y, float z):
        return Vector3.new(x, y, z)

    @staticmethod
    cdef inline Vector3 cfrom_xyz(double x, double y, double z):
        return Vector3.new(x, y, z)

    @staticmethod
    def from_vector3(Vector3 other):
        return Vector3.cfrom_vector3(other)

    @staticmethod
    def from_tuple(tuple other):
        return Vector3.cfrom_tuple(other)

    @staticmethod
    def from_list(list other):
        return Vector3.cfrom_list(other)

    @staticmethod
    def from_ints(int x, int y, int z):
        return Vector3.cfrom_ints(x, y, z)

    @staticmethod
    def from_floats(float x, float y, float z):
        return Vector3.cfrom_floats(x, y, z)

    @staticmethod
    def from_xyz(double x, double y, double z):
        return Vector3.cfrom_xyz(x, y, z)

    @property
    def xxx(self): return Vector3.new(self.data.x, self.data.x, self.data.x)
    @property
    def xxy(self): return Vector3.new(self.data.x, self.data.x, self.data.y)
    @property
    def xxz(self): return Vector3.new(self.data.x, self.data.x, self.data.z)
    @property
    def xyx(self): return Vector3.new(self.data.x, self.data.y, self.data.x)
    @property
    def xyy(self): return Vector3.new(self.data.x, self.data.y, self.data.y)
    @property
    def xyz(self): return Vector3.new(self.data.x, self.data.y, self.data.z)
    @property
    def xzy(self): return Vector3.new(self.data.x, self.data.z, self.data.y)
    @property
    def xzx(self): return Vector3.new(self.data.x, self.data.z, self.data.x)
    @property
    def xzz(self): return Vector3.new(self.data.x, self.data.z, self.data.z)

    @property
    def yxx(self): return Vector3.new(self.data.y, self.data.x, self.data.x)
    @property
    def yxy(self): return Vector3.new(self.data.y, self.data.x, self.data.y)
    @property
    def yxz(self): return Vector3.new(self.data.y, self.data.x, self.data.z)
    @property
    def yyx(self): return Vector3.new(self.data.y, self.data.y, self.data.x)
    @property
    def yyy(self): return Vector3.new(self.data.y, self.data.y, self.data.y)
    @property
    def yyz(self): return Vector3.new(self.data.y, self.data.y, self.data.z)
    @property
    def yzx(self): return Vector3.new(self.data.y, self.data.z, self.data.x)
    @property
    def yzy(self): return Vector3.new(self.data.y, self.data.z, self.data.y)
    @property
    def yzz(self): return Vector3.new(self.data.y, self.data.z, self.data.z)

    @property
    def zxx(self): return Vector3.new(self.data.z, self.data.x, self.data.x)
    @property
    def zxy(self): return Vector3.new(self.data.z, self.data.x, self.data.y)
    @property
    def zxz(self): return Vector3.new(self.data.z, self.data.x, self.data.z)
    @property
    def zyx(self): return Vector3.new(self.data.z, self.data.y, self.data.x)
    @property
    def zyy(self): return Vector3.new(self.data.z, self.data.y, self.data.y)
    @property
    def zyz(self): return Vector3.new(self.data.z, self.data.y, self.data.z)
    @property
    def zzx(self): return Vector3.new(self.data.z, self.data.z, self.data.x)
    @property
    def zzy(self): return Vector3.new(self.data.z, self.data.z, self.data.y)
    @property
    def zzz(self): return Vector3.new(self.data.z, self.data.z, self.data.z)

    def __getitem__(self, int index):
        cdef vector3_t data = self.data
        if index == 0:
            return data.x
        elif index == 1:
            return data.y
        elif index == 2:
            return data.z
        else:
            raise IndexError("Vector index out of range")

    def __setitem__(self, int index, double value):
        if index == 0:
            self.data.x = value
        elif index == 1:
            self.data.y = value
        elif index == 2:
            self.data.z = value
        else:
            raise IndexError("Vector index out of range")

    def __add__(self, Vector3 other):
        cdef vector3_t res = vector3_add(self.data, other.data)
        return Vector3.new(res.x, res.y, res.z)

    def __sub__(self, Vector3 other):
        cdef vector3_t res = vector3_sub(self.data, other.data)
        return Vector3.new(res.x, res.y, res.z)

    def __mul__(self, other):
        cdef vector3_t res
        if isinstance(other, Vector3):
            res = vector3_mul_vector(self.data, (<Vector3>other).data)
            return Vector3.new(res.x, res.y, res.z)
        elif isinstance(other, (int, float)):
            res = vector3_mul_scalar(self.data, other)
            return Vector3.new(res.x, res.y, res.z)
        return NotImplemented

    def __truediv__(self, other):
        cdef vector3_t res
        if isinstance(other, Vector3):
            res = vector3_div_vector(self.data, (<Vector3>other).data)
            return Vector3.new(res.x, res.y, res.z)
        elif isinstance(other, (int, float)):
            res = vector3_div_scalar(self.data, other)
            return Vector3.new(res.x, res.y, res.z)
        return NotImplemented

    def __floordiv__(self, other):
        cdef vector3_t res
        if isinstance(other, Vector3):
            res = vector3_floordiv_vector(self.data, (<Vector3>other).data)
            return Vector3.new(res.x, res.y, res.z)
        elif isinstance(other, (int, float)):
            res = vector3_floordiv_scalar(self.data, other)
            return Vector3.new(res.x, res.y, res.z)
        return NotImplemented

    def __iadd__(self, Vector3 other):
        vector3_iadd(&self.data, other.data)
        return self

    def __isub__(self, Vector3 other):
        vector3_isub(&self.data, other.data)
        return self

    def __imul__(self, Vector3 other):
        vector3_imul(&self.data, other.data)
        return self

    def __neg__(self):
        return self.get_neg()

    def __repr__(self):
        return f"Vector3({self.data.x}, {self.data.y}, {self.data.z})"

    def __copy__(self):
        cdef vector3_t data = self.data
        return Vector3.new(data.x, data.y, data.z)

    def __deepcopy__(self, memo):
        cdef vector3_t data = self.data
        return Vector3.new(data.x, data.y, data.z)

    def __hash__(self):
        cdef vector3_t data = self.data
        return hash((data.x, data.y, data.z))

    def __len__(self):
        return 3

    def __eq__(self, other):
        cdef vector3_t other_data
        if isinstance(other, Vector3):
            other_data = (<Vector3>other).data
            return self.data.x == other_data.x and self.data.y == other_data.y and self.data.z == other_data.z
        return False

    cdef inline Vector3 _add(self, Vector3 other):
        cdef vector3_t res = vector3_add(self.data, other.data)
        return Vector3.new(res.x, res.y, res.z)

    cdef inline Vector3 _sub(self, Vector3 other):
        cdef vector3_t res = vector3_sub(self.data, other.data)
        return Vector3.new(res.x, res.y, res.z)

    cdef inline void _iadd(self, Vector3 other) nogil:
        vector3_iadd(&self.data, other.data)

    cdef inline void _sadd(self, Vector3 new_vec, Vector3 old_vec) nogil:
        self.data.x = new_vec.data.x + old_vec.data.x
        self.data.y = new_vec.data.y + old_vec.data.y
        self.data.z = new_vec.data.z + old_vec.data.z

    cdef inline void _isub(self, Vector3 other) nogil:
        vector3_isub(&self.data, other.data)

    cdef inline void _imul(self, Vector3 other) nogil:
        vector3_imul(&self.data, other.data)

    cpdef void sadd(self, Vector3 new_vec, Vector3 old_vec):
        self._sadd(new_vec, old_vec)

    cpdef tuple get_tuple(self):
        return self.c_get_tuple()

    cdef inline tuple c_get_tuple(self):
        cdef vector3_t data = self.data
        return (data.x, data.y, data.z)

    cpdef Vector3 to_round(self):
        cdef vector3_t data = self.data
        self.data.x = round(data.x)
        self.data.y = round(data.y)
        self.data.z = round(data.z)
        return self

    cpdef Vector3 get_round(self):
        cdef vector3_t data = self.data
        return Vector3.new(round(data.x), round(data.y), round(data.z))

    cpdef Vector3 to_abs(self):
        cdef vector3_t data = self.data
        self.data.x = abs(data.x)
        self.data.y = abs(data.y)
        self.data.z = abs(data.z)
        return self

    cpdef Vector3 get_abs(self):
        cdef vector3_t data = self.data
        return Vector3.new(abs(data.x), abs(data.y), abs(data.z))

    cpdef Vector3 to_neg(self):
        cdef vector3_t data = self.data
        self.data.x = -data.x
        self.data.y = -data.y
        self.data.z = -data.z
        return self

    cpdef Vector3 get_neg(self):
        cdef vector3_t data = self.data
        return Vector3.new(-data.x, -data.y, -data.z)

    cpdef tuple get_int_tuple(self):
        cdef vector3_t data = self.data
        return (<int>data.x, <int>data.y, <int>data.z)

    cpdef tuple get_rounded_tuple(self):
        cdef vector3_t data = self.data
        return (<int>round(data.x), <int>round(data.y), <int>round(data.z))

    cpdef Vector3 copy(self):
        cdef vector3_t data = self.data
        return Vector3.new(data.x, data.y, data.z)

    @property
    def length(self):
        return vector3_length(self.data)

    cpdef Vector3 to_normalized(self):
        self.data = vector3_normalize(self.data)
        return self

    cpdef Vector3 get_normalized(self):
        cdef vector3_t res = vector3_normalize(self.data)
        return Vector3.new(res.x, res.y, res.z)

    cpdef double distance_to(self, Vector3 other):
        return vector3_distance_to(self.data, other.data)

    cpdef double distance_squared_to(self, Vector3 other):
        return vector3_distance_squared_to(self.data, other.data)

    cpdef double dot(self, Vector3 other):
        return vector3_dot(self.data, other.data)

    cpdef Vector3 cross(self, Vector3 other):
        cdef vector3_t res = vector3_cross(self.data, other.data)
        return Vector3.new(res.x, res.y, res.z)
