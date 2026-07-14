from cyrlib.raylib.raylib cimport (
    DrawFPS, ClearBackground, BeginDrawing, EndDrawing, DrawTexture
)
from cyrlib.texture.texture cimport Texture
from cyrlib.color.color cimport Color
from cyrlib.vector2.vector2 cimport Vector2

cdef class Cycle:
    def __enter__(self):
        BeginDrawing()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        EndDrawing()
        return False

cycle = Cycle()

cpdef void fps(int x, int y):
    DrawFPS(x, y)

cpdef void fps_vec(Vector2 position):
    DrawFPS(position.x, position.y)

cpdef void clear_background_flat(int r, int g, int b, int a):
    cdef Color color = Color(r, g, b, a)
    ClearBackground(color._raw)

cpdef void clear_background(Color color):
    ClearBackground(color._raw)

cpdef void begin():
    BeginDrawing()

cpdef void end():
    EndDrawing()

def texture(Texture texture, int pos_x, int pos_y, Color tint):
    DrawTexture(texture._raw, pos_x, pos_y, tint._raw)
