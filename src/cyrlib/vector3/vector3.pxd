from libc.math cimport sqrt
cimport cython
from cyrlib.raylib.raylib cimport Vector3 as vector3_t

cdef inline vector3_t vector3_new(double x, double y, double z) noexcept nogil:
    cdef vector3_t v
    v.x = x
    v.y = y
    v.z = z
    return v

cdef inline vector3_t vector3_add(vector3_t a, vector3_t b) noexcept nogil:
    return vector3_new(a.x + b.x, a.y + b.y, a.z + b.z)

cdef inline vector3_t vector3_add_triple(vector3_t a, vector3_t b, vector3_t c) noexcept nogil:
    return vector3_new(a.x + b.x + c.x, a.y + b.y + c.y, a.z + b.z + c.z)

cdef inline vector3_t vector3_sub(vector3_t a, vector3_t b) noexcept nogil:
    return vector3_new(a.x - b.x, a.y - b.y, a.z - b.z)

cdef inline vector3_t vector3_mul_scalar(vector3_t a, double val) noexcept nogil:
    return vector3_new(a.x * val, a.y * val, a.z * val)

cdef inline vector3_t vector3_mul_vector(vector3_t a, vector3_t b) noexcept nogil:
    return vector3_new(a.x * b.x, a.y * b.y, a.z * b.z)

cdef inline vector3_t vector3_div_scalar(vector3_t a, double val) noexcept nogil:
    return vector3_new(a.x / val, a.y / val, a.z / val)

cdef inline vector3_t vector3_div_vector(vector3_t a, vector3_t b) noexcept nogil:
    return vector3_new(a.x / b.x, a.y / b.y, a.z / b.z)

cdef inline vector3_t vector3_floordiv_scalar(vector3_t a, double val) noexcept nogil:
    return vector3_new(a.x // val, a.y // val, a.z // val)

cdef inline vector3_t vector3_floordiv_vector(vector3_t a, vector3_t b) noexcept nogil:
    return vector3_new(a.x // b.x, a.y // b.y, a.z // b.z)

cdef inline void vector3_iadd(vector3_t *self, vector3_t other) noexcept nogil:
    self.x += other.x
    self.y += other.y
    self.z += other.z

cdef inline void vector3_isub(vector3_t *self, vector3_t other) noexcept nogil:
    self.x -= other.x
    self.y -= other.y
    self.z -= other.z

cdef inline void vector3_imul(vector3_t *self, vector3_t other) noexcept nogil:
    self.x *= other.x
    self.y *= other.y
    self.z *= other.z

cdef inline double vector3_length(vector3_t v) noexcept nogil:
    return sqrt(v.x * v.x + v.y * v.y + v.z * v.z)

cdef inline vector3_t vector3_normalize(vector3_t v) noexcept nogil:
    cdef double l = sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
    if l == 0.0:
        return vector3_new(0.0, 0.0, 0.0)
    cdef double inv_l = 1.0 / l
    return vector3_new(v.x * inv_l, v.y * inv_l, v.z * inv_l)

cdef inline double vector3_distance_to(vector3_t a, vector3_t b) noexcept nogil:
    cdef double dx = a.x - b.x
    cdef double dy = a.y - b.y
    cdef double dz = a.z - b.z
    return sqrt(dx * dx + dy * dy + dz * dz)

cdef inline double vector3_distance_squared_to(vector3_t a, vector3_t b) noexcept nogil:
    cdef double dx = a.x - b.x
    cdef double dy = a.y - b.y
    cdef double dz = a.z - b.z
    return dx * dx + dy * dy + dz * dz

cdef inline double vector3_dot(vector3_t a, vector3_t b) noexcept nogil:
    return a.x * b.x + a.y * b.y + a.z * b.z

cdef inline vector3_t vector3_cross(vector3_t a, vector3_t b) noexcept nogil:
    return vector3_new(
        a.y * b.z - a.z * b.y,
        a.z * b.x - a.x * b.z,
        a.x * b.y - a.y * b.x
    )

@cython.final
cdef class Vector3:
    cdef vector3_t data

    @staticmethod
    cdef inline Vector3 new(double x, double y, double z)

    @staticmethod
    cdef inline Vector3 cfrom_list(list other)

    @staticmethod
    cdef inline Vector3 cfrom_ints(int x, int y, int z)

    @staticmethod
    cdef inline Vector3 cfrom_floats(float x, float y, float z)

    @staticmethod
    cdef inline Vector3 cfrom_tuple(tuple other)

    @staticmethod
    cdef inline Vector3 cfrom_vector3(Vector3 other)

    @staticmethod
    cdef inline Vector3 cfrom_xyz(double x, double y, double z)

    cdef inline Vector3 _add(self, Vector3 other)
    cdef inline Vector3 _sub(self, Vector3 other)
    cdef inline void _iadd(self, Vector3 other) nogil
    cdef inline void _isub(self, Vector3 other) nogil
    cdef inline void _imul(self, Vector3 other) nogil
    cdef inline void _sadd(self, Vector3 new_vec, Vector3 old_vec) nogil

    cpdef void sadd(self, Vector3 new_vec, Vector3 old_vec)
    cpdef tuple get_tuple(self)
    cdef inline tuple c_get_tuple(self)
    cpdef Vector3 to_round(self)
    cpdef Vector3 get_round(self)
    cpdef Vector3 to_abs(self)
    cpdef Vector3 get_abs(self)
    cpdef Vector3 to_neg(self)
    cpdef Vector3 get_neg(self)
    cpdef tuple get_int_tuple(self)
    cpdef tuple get_rounded_tuple(self)
    cpdef Vector3 copy(self)
    cpdef Vector3 to_normalized(self)
    cpdef Vector3 get_normalized(self)
    cpdef double distance_to(self, Vector3 other)
    cpdef double distance_squared_to(self, Vector3 other)
    cpdef double dot(self, Vector3 other)
    cpdef Vector3 cross(self, Vector3 other)
