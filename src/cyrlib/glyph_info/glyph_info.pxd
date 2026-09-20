from cyrlib.raylib.raylib cimport (
    GlyphInfo as glyph_info_t
)
from cyrlib.image.image cimport Image

cdef class GlyphInfo:
    cdef glyph_info_t _raw
    cdef Image _image

    @staticmethod
    cdef inline GlyphInfo new(glyph_info_t raw)