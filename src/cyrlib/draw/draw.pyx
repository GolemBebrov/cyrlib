from cyrlib.raylib.raylib cimport (
    DrawFPS, ClearBackground, BeginDrawing, EndDrawing, 
    DrawTexture, DrawTextureV, DrawTextureEx, DrawTextureRec
)
from cyrlib.texture.texture cimport Texture
from cyrlib.color.color cimport Color, RlColor, color_new
from cyrlib.vector2.vector2 cimport vector2_t, vector2_new, Vector2
from cyrlib.rect.rect cimport Rectangle, Rect, rectangle_new
cdef inline vector2_t __parse_dest_like(object dest) except *:
    if isinstance(dest, Vector2):
        return (<Vector2>dest).data
    elif isinstance(dest, list | tuple):
        if len(dest) != 2:
            raise ValueError("list/tuple for dest_like argument must have only 2 elements")
        return  vector2_new(dest[0], dest[1])
    else:
        raise TypeError(f"dest_like argument must be Vector2, tuple, or list, got {type(dest).__name__}")

cdef inline RlColor __parse_color_like(object color) except *:
    if isinstance(color, Color):
        return (<Color>color)._raw
    elif isinstance(color, list | tuple):
        if not (2 < len(color) < 5):
            raise ValueError("list/tuple for color_like argument must have only 3-4 elements")
        return color_new(color[0], color[1], color[2], color[3] if len(color) == 4 else 255)
    else:
        raise TypeError(f"color_like argument must be Color, tuple, or list, got {type(color).__name__}")

cdef inline Rectangle __parse_rect_like(object rect) except *:
    if isinstance(rect, Rect):
        return (<Rect>rect)._raw
    elif isinstance(rect, list | tuple):
        if len(rect) != 4:
            raise ValueError("list/tuple for rect_like argument must have only 4 elements")
        return rectangle_new(rect[0], rect[1], rect[2], rect[3])
    else:
        raise TypeError(f"rect_like argument must be Rect, tuple, or list, got {type(rect).__name__}")

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

cpdef void fps_vec(object position):
    cdef vector2_t vec_pos = __parse_dest_like(position)
    DrawFPS(<int>vec_pos.x, <int>vec_pos.y)

cpdef void clear_background_flat(int r, int g, int b, int a):
    cdef RlColor color = color_new(r, g, b, a)
    ClearBackground(color)

cpdef void clear_background(object color):
    cdef RlColor color_struct = __parse_color_like(color)
    ClearBackground(color_struct)

cpdef void begin():
    BeginDrawing()

cpdef void end():
    EndDrawing()

cpdef void texture(Texture tex, int pos_x, int pos_y, object tint):
    cdef RlColor color_tint = __parse_color_like(tint)
    DrawTexture(tex._raw, pos_x, pos_y, color_tint)

cpdef void texture_vec(Texture texture, object pos, object tint):
    cdef RlColor color_tint = __parse_color_like(tint)
    cdef vector2_t vec_pos = __parse_dest_like(pos)
    DrawTextureV(texture._raw, vec_pos, color_tint)

cpdef void texture_ex(Texture tex, object pos, float rotation, float scale, object tint):
    cdef RlColor color_tint = __parse_color_like(tint)
    cdef vector2_t vec_pos = __parse_dest_like(pos)
    DrawTextureEx(tex._raw, vec_pos, rotation, scale, color_tint)

cpdef void texture_rec(Texture tex, object rect, object pos, object tint):
    cdef RlColor color_tint = __parse_color_like(tint)
    cdef Rectangle rectangle = __parse_rect_like(rect)
    cdef vector2_t vec_pos = __parse_dest_like(pos)
    DrawTextureRec(tex._raw, rectangle, vec_pos, color_tint)