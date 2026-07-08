from nv_raylib.raylib.raylib cimport DrawFPS, ClearBackground
from nv_raylib.color.color cimport Color
from nv_raylib.vector2.vector2 cimport Vector2
cdef class draw:

    @staticmethod
    def fps_flat(int x, int y):
        DrawFPS(x, y)

    @staticmethod
    def fps(Vector2 position):
        DrawFPS(position.x, position.y)

    @staticmethod
    def clear_background_flat(int r, int g, int b, int a):
        cdef Color color = Color(r, g, b, a)
        ClearBackground(color._raw)

    @staticmethod
    def clear_background(Color color):
        ClearBackground(color._raw)
