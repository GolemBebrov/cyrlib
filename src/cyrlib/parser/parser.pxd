from cyrlib.vector2.vector2 cimport vector2_t
from cyrlib.color.color cimport RlColor
from cyrlib.rect.rect cimport Rectangle

cdef inline vector2_t parse_vector2_like(object dest) except *
cdef inline RlColor parse_color_like(object color) except *
cdef inline Rectangle parse_rect_like(object rect) except *