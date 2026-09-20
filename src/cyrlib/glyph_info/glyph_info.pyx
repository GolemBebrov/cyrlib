from cyrlib.raylib.raylib cimport (
    GlyphInfo as glyph_info_t
)
from cyrlib.image.image cimport Image

cdef class GlyphInfo:
    @staticmethod
    cdef inline GlyphInfo new(glyph_info_t raw):
        cdef GlyphInfo glyph_info = GlyphInfo.__new__(GlyphInfo)
        glyph_info._raw = raw
        glyph_info._image = Image.new(raw.image, is_owner=False)
        return glyph_info