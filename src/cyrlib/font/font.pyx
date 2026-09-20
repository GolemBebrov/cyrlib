from cyrlib.raylib.raylib cimport (
    Font as font_t,
    LoadFont,
    LoadFontEx,
    UnloadFont,
    IsFontValid,
    GetFontDefault
)
from cyrlib.texture.texture cimport Texture
from cyrlib.glyph_info.glyph_info cimport GlyphInfo  
from libc.stdlib cimport malloc, free

cdef class Font:
    @staticmethod
    cdef inline Font new(font_t raw, bint is_owner=True):
        cdef Font font = Font.__new__(Font)
        font._raw = raw
        font._is_owner = is_owner
        font._texture = Texture.new(raw.texture, is_owner=False)
        return font

    def __dealloc__(self):
        if self._is_owner:
            self.c_unload()

    cdef inline void c_unload(self):
        if self._raw.texture.id > 0:
            UnloadFont(self._raw)
            self._raw.texture.id = 0
            self._raw.glyphs = NULL
            self._raw.recs = NULL

    def unload(self):
        self.c_unload()

    @staticmethod
    def load(str filename) -> Font:
        cdef bytes b_filename = filename.encode("utf-8")
        return Font.new(LoadFont(b_filename), is_owner=True)

    @staticmethod
    def load_ex(str filename, int font_size, object codepoints=None) -> Font:
        cdef bytes b_filename = filename.encode("utf-8")
        cdef int *c_codepoints = NULL
        cdef int count = 0
        cdef list cp_list

        if codepoints is not None:
            cp_list = list(codepoints)
            count = len(cp_list)
            c_codepoints = <int *>malloc(count * sizeof(int))
            for i in range(count):
                c_codepoints[i] = cp_list[i]

        cdef font_t raw
        try:
            raw = LoadFontEx(b_filename, font_size, c_codepoints, count)
        finally:
            if c_codepoints != NULL:
                free(c_codepoints)

        return Font.new(raw, is_owner=True)

    @staticmethod
    def default_font() -> Font:
        return Font.new(GetFontDefault(), is_owner=False)

    @property
    def valid(self) -> bool:
        return IsFontValid(self._raw)

    @property
    def base_size(self) -> int:
        return self._raw.baseSize

    @property
    def glyph_count(self) -> int:
        return self._raw.glyphCount

    @property
    def texture(self) -> Texture:
        return self._texture

    def get_glyph(self, int index) -> GlyphInfo:
        if index < 0 or index >= self._raw.glyphCount:
            raise IndexError("Glyph index out of range")
        return GlyphInfo.new(self._raw.glyphs[index])