from cyrlib.raylib.raylib cimport DrawFPS, ClearBackground
from cyrlib.color.color cimport Color
from cyrlib.vector2.vector2 cimport Vector2

def fps_flat(int x, int y):
    DrawFPS(x, y)

def fps(Vector2 position):
    DrawFPS(position.x, position.y)

def clear_background_flat(int r, int g, int b, int a):
    cdef Color color = Color(r, g, b, a)
    ClearBackground(color._raw)

def clear_background(Color color):
    ClearBackground(color._raw)
