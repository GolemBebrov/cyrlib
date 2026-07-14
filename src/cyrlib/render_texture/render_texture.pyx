from cyrlib.raylib.raylib cimport (
    RenderTexture2D as r_texture_t, LoadRenderTexture,
    UnloadRenderTexture, IsRenderTextureValid, BeginTextureMode, EndTextureMode
)

from cyrlib.texture.texture cimport Texture


cdef class RenderTexture:
    @staticmethod
    cdef RenderTexture new(int width, int height):
        cdef RenderTexture rt = RenderTexture()
        rt._raw = LoadRenderTexture(width, height)
        rt._texture = Texture.new(rt._raw.texture)
        return rt

    def __init__(self, int width, int height):
        self._raw = LoadRenderTexture(width, height)
        self._texture = Texture.new(self._raw.texture)

    def __enter__(self):
        BeginTextureMode(self._raw)
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        EndTextureMode()
        return False

    def __dealloc__(self):
        self.c_unload()

    cdef inline void c_unload(self):
        if self.valid:
            UnloadRenderTexture(self._raw)

    cpdef void begin(self):
        BeginTextureMode(self._raw)

    cpdef void end(self):
        EndTextureMode()

    def unload(self):
        self.c_unload()

    @property
    def valid(self) -> bool:
        return IsRenderTextureValid(self._raw)

    @property
    def texture(self) -> Texture:
        return self._texture
