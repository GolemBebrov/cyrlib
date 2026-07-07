from libc.math cimport sqrt
cimport cython

ctypedef struct vector4_t:
    double x
    double y
    double z
    double w

cdef inline vector4_t vector4_new(double x, double y, double z, double w) noexcept nogil:
    cdef vector4_t v
    v.x = x
    v.y = y
    v.z = z
    v.w = w
    return v

cdef inline vector4_t vector4_add(vector4_t a, vector4_t b) noexcept nogil:
    return vector4_new(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)

cdef inline vector4_t vector4_add_triple(vector4_t a, vector4_t b, vector4_t c) noexcept nogil:
    return vector4_new(a.x + b.x + c.x, a.y + b.y + c.y, a.z + b.z + c.z, a.w + b.w + c.w)

cdef inline vector4_t vector4_sub(vector4_t a, vector4_t b) noexcept nogil:
    return vector4_new(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)

cdef inline vector4_t vector4_mul_scalar(vector4_t a, double val) noexcept nogil:
    return vector4_new(a.x * val, a.y * val, a.z * val, a.w * val)

cdef inline vector4_t vector4_mul_vector(vector4_t a, vector4_t b) noexcept nogil:
    return vector4_new(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w)

cdef inline vector4_t vector4_div_scalar(vector4_t a, double val) noexcept nogil:
    return vector4_new(a.x / val, a.y / val, a.z / val, a.w / val)

cdef inline vector4_t vector4_div_vector(vector4_t a, vector4_t b) noexcept nogil:
    return vector4_new(a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w)

cdef inline vector4_t vector4_floordiv_scalar(vector4_t a, double val) noexcept nogil:
    return vector4_new(a.x // val, a.y // val, a.z // val, a.w // val)

cdef inline vector4_t vector4_floordiv_vector(vector4_t a, vector4_t b) noexcept nogil:
    return vector4_new(a.x // b.x, a.y // b.y, a.z // b.z, a.w // b.w)

cdef inline void vector4_iadd(vector4_t *self, vector4_t other) noexcept nogil:
    self.x += other.x
    self.y += other.y
    self.z += other.z
    self.w += other.w

cdef inline void vector4_isub(vector4_t *self, vector4_t other) noexcept nogil:
    self.x -= other.x
    self.y -= other.y
    self.z -= other.z
    self.w -= other.w

cdef inline void vector4_imul(vector4_t *self, vector4_t other) noexcept nogil:
    self.x *= other.x
    self.y *= other.y
    self.z *= other.z
    self.w *= other.w

cdef inline double vector4_length(vector4_t v) noexcept nogil:
    return sqrt(v.x * v.x + v.y * v.y + v.z * v.z + v.w * v.w)

cdef inline vector4_t vector4_normalize(vector4_t v) noexcept nogil:
    cdef double l = sqrt(v.x * v.x + v.y * v.y + v.z * v.z + v.w * v.w)
    if l == 0.0:
        return vector4_new(0.0, 0.0, 0.0, 0.0)
    cdef double inv_l = 1.0 / l
    return vector4_new(v.x * inv_l, v.y * inv_l, v.z * inv_l, v.w * inv_l)

cdef inline double vector4_distance_to(vector4_t a, vector4_t b) noexcept nogil:
    cdef double dx = a.x - b.x
    cdef double dy = a.y - b.y
    cdef double dz = a.z - b.z
    cdef double dw = a.w - b.w
    return sqrt(dx * dx + dy * dy + dz * dz + dw * dw)

cdef inline double vector4_distance_squared_to(vector4_t a, vector4_t b) noexcept nogil:
    cdef double dx = a.x - b.x
    cdef double dy = a.y - b.y
    cdef double dz = a.z - b.z
    cdef double dw = a.w - b.w
    return dx * dx + dy * dy + dz * dz + dw * dw

cdef inline double vector4_dot(vector4_t a, vector4_t b) noexcept nogil:
    return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w

@cython.final
cdef class Vector4:
    cdef vector4_t data

    @staticmethod
    cdef inline Vector4 new(double x, double y, double z, double w)

    @staticmethod
    cdef inline Vector4 cfrom_list(list other)

    @staticmethod
    cdef inline Vector4 cfrom_ints(int x, int y, int z, int w)

    @staticmethod
    cdef inline Vector4 cfrom_floats(float x, float y, float z, float w)

    @staticmethod
    cdef inline Vector4 cfrom_tuple(tuple other)

    @staticmethod
    cdef inline Vector4 cfrom_vector4(Vector4 other)

    @staticmethod
    cdef inline Vector4 cfrom_xyzw(double x, double y, double z, double w)

    cdef inline Vector4 _add(self, Vector4 other)
    cdef inline Vector4 _sub(self, Vector4 other)
    cdef inline void _iadd(self, Vector4 other) nogil
    cdef inline void _isub(self, Vector4 other) nogil
    cdef inline void _imul(self, Vector4 other) nogil
    cdef inline void _sadd(self, Vector4 new_vec, Vector4 old_vec) nogil

    cpdef void sadd(self, Vector4 new_vec, Vector4 old_vec)
    cpdef tuple get_tuple(self)
    cdef inline tuple c_get_tuple(self)
    cpdef Vector4 to_round(self)
    cpdef Vector4 get_round(self)
    cpdef Vector4 to_abs(self)
    cpdef Vector4 get_abs(self)
    cpdef Vector4 to_neg(self)
    cpdef Vector4 get_neg(self)
    cpdef tuple get_int_tuple(self)
    cpdef tuple get_rounded_tuple(self)
    cpdef Vector4 copy(self)
    cpdef Vector4 to_normalized(self)
    cpdef Vector4 get_normalized(self)
    cpdef double distance_to(self, Vector4 other)
    cpdef double distance_squared_to(self, Vector4 other)
    cpdef double dot(self, Vector4 other)
