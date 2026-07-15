from cyrlib.raylib.raylib cimport (
    Texture as texture_t, LoadTexture,
    LoadTextureFromImage, UnloadTexture, IsTextureValid,
    SetTextureFilter, SetTextureWrap,
)

from cyrlib.image.image cimport (
    Image
)

from cyrlib.enums import TextureFilter, TextureWrap

cdef class Texture:

    @staticmethod
    cdef inline Texture new(texture_t struct):
        cdef Texture texture = Texture.__new__(Texture)
        texture._raw = struct
        texture._filter = TextureFilter.Bilinear
        texture._wrap = TextureWrap.Repeat
        return texture

    def __dealloc__(self):
        if self.valid:
            self.c_unload()

    @staticmethod
    cdef inline Texture c_load(str file_name):
        cdef bytes file_name_bytes = file_name.encode("utf-8")
        return Texture.new(LoadTexture(file_name))

    @staticmethod
    cdef inline Texture c_load_from_image(Image image):
        return Texture.new(LoadTextureFromImage(image._raw))

    cdef inline void c_unload(self):
        UnloadTexture(self._raw)

    def unload(self):
        self.c_unload()

    @staticmethod
    def load(str file_name) -> Texture:
        return Texture.c_load(file_name)

    @staticmethod
    def load_from_image(Image image) -> Texture:
        return Texture.c_load_from_image(image)

    @property
    def valid(self) -> bool:
        return IsTextureValid(self._raw)

    @property
    def filter(self) -> int:
        return self._filter

    @filter.setter
    def filter(self, int value):
        self._filter = value
        SetTextureFilter(self._raw, value)

    @property
    def wrap(self) -> int:
        return self._wrap

    @wrap.setter
    def wrap(self, int value):
        self._wrap = value
        SetTextureWrap(self._raw, value)

    @property
    def id(self) -> int:
        return self._raw.id

    @property
    def width(self) -> int:
        return self._raw.width

    @property
    def height(self) -> int:
        return self._raw.height

    @property
    def mipmaps(self) -> int:
        return self._raw.mipmaps

    @property
    def format(self) -> int:
        return self._raw.format
