from libc.math cimport sqrt
cimport cython
from cyrlib.raylib.raylib cimport Vector2 as vector2_t

cdef inline vector2_t vector2_new(double x, double y) noexcept nogil:
    cdef vector2_t v
    v.x = x
    v.y = y
    return v

cdef inline vector2_t vector2_add(vector2_t a, vector2_t b) noexcept nogil:
    return vector2_new(a.x + b.x, a.y + b.y)

cdef inline vector2_t vector2_add_triple(vector2_t a, vector2_t b, vector2_t c) noexcept nogil:
    return vector2_new(a.x + b.x + c.x, a.y + b.y + c.y)

cdef inline vector2_t vector2_sub(vector2_t a, vector2_t b) noexcept nogil:
    return vector2_new(a.x - b.x, a.y - b.y)

cdef inline vector2_t vector2_mul_scalar(vector2_t a, double val) noexcept nogil:
    return vector2_new(a.x * val, a.y * val)

cdef inline vector2_t vector2_mul_vector(vector2_t a, vector2_t b) noexcept nogil:
    return vector2_new(a.x * b.x, a.y * b.y)

cdef inline vector2_t vector2_div_scalar(vector2_t a, double val) noexcept nogil:
    return vector2_new(a.x / val, a.y / val)

cdef inline vector2_t vector2_div_vector(vector2_t a, vector2_t b) noexcept nogil:
    return vector2_new(a.x / b.x, a.y / b.y)

cdef inline vector2_t vector2_floordiv_scalar(vector2_t a, double val) noexcept nogil:
    return vector2_new(a.x // val, a.y // val)

cdef inline vector2_t vector2_floordiv_vector(vector2_t a, vector2_t b) noexcept nogil:
    return vector2_new(a.x // b.x, a.y // b.y)

cdef inline void vector2_iadd(vector2_t *self, vector2_t other) noexcept nogil:
    self.x += other.x
    self.y += other.y

cdef inline void vector2_isub(vector2_t *self, vector2_t other) noexcept nogil:
    self.x -= other.x
    self.y -= other.y

cdef inline void vector2_imul(vector2_t *self, vector2_t other) noexcept nogil:
    self.x *= other.x
    self.y *= other.y

cdef inline double vector2_length(vector2_t v) noexcept nogil:
    return sqrt(v.x * v.x + v.y * v.y)

cdef inline vector2_t vector2_normalize(vector2_t v) noexcept nogil:
    cdef double l = sqrt(v.x * v.x + v.y * v.y)
    if l == 0.0:
        return vector2_new(0.0, 0.0)
    cdef double inv_l = 1.0 / l
    return vector2_new(v.x * inv_l, v.y * inv_l)

cdef inline double vector2_distance_to(vector2_t a, vector2_t b) noexcept nogil:
    cdef double dx = a.x - b.x
    cdef double dy = a.y - b.y
    return sqrt(dx * dx + dy * dy)

cdef inline double vector2_distance_squared_to(vector2_t a, vector2_t b) noexcept nogil:
    cdef double dx = a.x - b.x
    cdef double dy = a.y - b.y
    return dx * dx + dy * dy

cdef inline double vector2_dot(vector2_t a, vector2_t b) noexcept nogil:
    return a.x * b.x + a.y * b.y

@cython.final
cdef class Vector2:
    cdef vector2_t data

    @staticmethod
    cdef inline Vector2 new(double x, double y)

    @staticmethod
    cdef inline Vector2 cfrom_struct(vector2_t other)

    @staticmethod
    cdef inline Vector2 cfrom_list(list other)

    @staticmethod
    cdef inline Vector2 cfrom_ints(int x, int y)

    @staticmethod
    cdef inline Vector2 cfrom_floats(float x, float y)

    @staticmethod
    cdef inline Vector2 cfrom_tuple(tuple other)

    @staticmethod
    cdef inline Vector2 cfrom_vector2(Vector2 other)

    @staticmethod
    cdef inline Vector2 cfrom_xy(double x, double y)

    cdef inline Vector2 _add(self, Vector2 other)
    cdef inline Vector2 _sub(self, Vector2 other)
    cdef inline void _iadd(self, Vector2 other) nogil
    cdef inline void _isub(self, Vector2 other) nogil
    cdef inline void _imul(self, Vector2 other) nogil
    cdef inline void _sadd(self, Vector2 new_vec, Vector2 old_vec) nogil

    cpdef void sadd(self, Vector2 new_vec, Vector2 old_vec)
    cpdef tuple get_tuple(self)
    cdef inline tuple c_get_tuple(self)
    cpdef Vector2 to_round(self)
    cpdef Vector2 get_round(self)
    cpdef Vector2 to_abs(self)
    cpdef Vector2 get_abs(self)
    cpdef Vector2 to_neg(self)
    cpdef Vector2 get_neg(self)
    cpdef tuple get_int_tuple(self)
    cpdef tuple get_rounded_tuple(self)
    cpdef Vector2 copy(self)
    cpdef Vector2 to_normalized(self)
    cpdef Vector2 get_normalized(self)
    cpdef double distance_to(self, Vector2 other)
    cpdef double distance_squared_to(self, Vector2 other)
    cpdef double dot(self, Vector2 other)
