from cyrlib.raylib.raylib cimport (
    DrawFPS, ClearBackground, BeginDrawing, EndDrawing
)
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

def fps_flat(int x, int y):
    DrawFPS(x, y)

def fps(Vector2 position):
    DrawFPS(position.x, position.y)

def clear_background_flat(int r, int g, int b, int a):
    cdef Color color = Color(r, g, b, a)
    ClearBackground(color._raw)

def clear_background(Color color):
    ClearBackground(color._raw)

cpdef void begin():
    BeginDrawing()

cpdef void end():
    EndDrawing()
