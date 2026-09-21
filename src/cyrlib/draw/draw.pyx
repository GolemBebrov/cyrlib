from cyrlib.raylib.raylib cimport (
    DrawFPS, ClearBackground, BeginDrawing, EndDrawing, 
    DrawTexture, DrawTextureV, DrawTextureEx, DrawTextureRec, 
    DrawTexturePro, DrawTextEx, DrawText, DrawPixel, DrawPixelV,
    DrawLine, DrawLineV, DrawLineEx, DrawLineStrip,
    DrawLineBezier, DrawLineDashed, DrawTriangle, DrawTriangleLines,
    DrawRectangle, DrawRectangleV, DrawRectangleRec, DrawRectanglePro,
    DrawRectangleGradientV, DrawRectangleGradientH, DrawRectangleGradientEx,
    DrawRectangleLines, DrawRectangleLinesEx, DrawRectangleRounded, 
    DrawRectangleRoundedLines, DrawRectangleRoundedLinesEx,
    DrawPoly

)
from cyrlib.texture.texture cimport Texture
from cyrlib.color.color cimport Color, RlColor, color_new
from cyrlib.colors.colors import colors
from cyrlib.vector2.vector2 cimport vector2_t, vector2_new, Vector2
from cyrlib.rect.rect cimport Rectangle, Rect, rectangle_new
from cyrlib.font.font cimport Font
from cyrlib.parser.parser cimport parse_color_like, parse_vector2_like, parse_rect_like

cdef class Cycle:
    def __enter__(self):
        BeginDrawing()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        EndDrawing()
        return False

cycle = Cycle()

ColorLike = Color | list[int] | tuple[int, int, int, int] | tuple[int, int, int]
Vector2Like = Vector2 | list[int] | tuple[int, int]
RectLike = Rect | list[int] | tuple[int, int, int, int]

cpdef void fps(int x, int y):
    DrawFPS(x, y)

cpdef void fps_vec(object position):
    cdef vector2_t vec_pos = parse_vector2_like(position)
    DrawFPS(<int>vec_pos.x, <int>vec_pos.y)

cpdef void clear_background_flat(int r, int g, int b, int a):
    cdef RlColor color = color_new(r, g, b, a)
    ClearBackground(color)

cpdef void clear_background(object color):
    cdef RlColor color_struct = parse_color_like(color)
    ClearBackground(color_struct)

cpdef void begin():
    BeginDrawing()

cpdef void end():
    EndDrawing()

cpdef void texture(Texture tex, int pos_x, int pos_y, object tint):
    cdef RlColor color_tint = parse_color_like(tint)
    DrawTexture(tex._raw, pos_x, pos_y, color_tint)

cpdef void texture_vec(Texture texture, object pos, object tint):
    cdef RlColor color_tint = parse_color_like(tint)
    cdef vector2_t vec_pos = parse_vector2_like(pos)
    DrawTextureV(texture._raw, vec_pos, color_tint)

cpdef void texture_ex(Texture tex, object pos, float rotation, float scale, object tint):
    cdef RlColor color_tint = parse_color_like(tint)
    cdef vector2_t vec_pos = parse_vector2_like(pos)
    DrawTextureEx(tex._raw, vec_pos, rotation, scale, color_tint)

cpdef void texture_rec(Texture tex, object rect, object pos, object tint):
    cdef RlColor color_tint = parse_color_like(tint)
    cdef Rectangle rectangle = parse_rect_like(rect)
    cdef vector2_t vec_pos = parse_vector2_like(pos)
    DrawTextureRec(tex._raw, rectangle, vec_pos, color_tint)

cpdef void texture_pro(Texture tex, object source_rect, object dest_rect, object origin, float rotation, object tint):
    cdef RlColor color_tint = parse_color_like(tint)
    cdef Rectangle c_source_rect, c_dest_rect
    c_source_rect = parse_rect_like(source_rect)
    c_dest_rect = parse_rect_like(dest_rect)
    cdef vector2_t vec_origin = parse_vector2_like(origin)
    DrawTexturePro(tex._raw, c_source_rect, c_dest_rect, vec_origin, rotation, color_tint)

cpdef void text(str txt, int pos_x, int pos_y, int font_size = 20, color: ColorLike = colors.White):
    cdef bytes b_text = txt.encode("utf-8")
    cdef RlColor color_tint = parse_color_like(color)
    DrawText(<const char *>b_text, pos_x, pos_y, font_size, color_tint)

cpdef void text_ex(Font font, str text, pos: Vector2Like, float font_size = 20, float spacing = 1.0, color: ColorLike = colors.White):
    cdef vector2_t vec_pos = parse_vector2_like(pos)
    cdef RlColor col = parse_color_like(color)
    cdef bytes b_text = text.encode("utf-8")
    DrawTextEx(font._raw, b_text, vec_pos, font_size, spacing, col)

cpdef void pixel(int pos_x, int pos_y, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    DrawPixel(pos_x, pos_y, col)

cpdef void pixel_vec(pos: Vector2Like, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef vector2_t vec_pos = parse_vector2_like(pos)
    DrawPixelV(vec_pos, col)

cpdef void line(int start_x, int start_y, int end_x, int end_y, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    DrawLine(start_x, start_y, end_x, end_y, col)

cpdef void line_vec(start: Vector2Like, end: Vector2Like, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef vector2_t vec_start = parse_vector2_like(start)
    cdef vector2_t vec_end = parse_vector2_like(end)
    DrawLineV(vec_start, vec_end, col)

cpdef void line_ex(start: Vector2Like, end: Vector2Like, float thickness = 1.0, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef vector2_t vec_start = parse_vector2_like(start)
    cdef vector2_t vec_end = parse_vector2_like(end)
    DrawLineEx(vec_start, vec_end, thickness, col)

cpdef void line_bezier(start: Vector2Like, end: Vector2Like, float thickness = 1.0, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef vector2_t vec_start = parse_vector2_like(start)
    cdef vector2_t vec_end = parse_vector2_like(end)
    DrawLineBezier(vec_start, vec_end, thickness, col)

cpdef void line_dashed(start: Vector2Like, end: Vector2Like, int dash_size = 1, int space_size = 1, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef vector2_t vec_start = parse_vector2_like(start)
    cdef vector2_t vec_end = parse_vector2_like(end)
    DrawLineDashed(vec_start, vec_end, dash_size, space_size, col)

cpdef void triangle(pos_1: Vector2Like, pos_2: Vector2Like, pos_3: Vector2Like, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef vector2_t vec_1 = parse_vector2_like(pos_1)
    cdef vector2_t vec_2 = parse_vector2_like(pos_2)
    cdef vector2_t vec_3 = parse_vector2_like(pos_3)
    DrawTriangle(vec_1, vec_2, vec_3, col)

cpdef void triangle_lines(pos_1: Vector2Like, pos_2: Vector2Like, pos_3: Vector2Like, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef vector2_t vec_1 = parse_vector2_like(pos_1)
    cdef vector2_t vec_2 = parse_vector2_like(pos_2)
    cdef vector2_t vec_3 = parse_vector2_like(pos_3)
    DrawTriangleLines(vec_1, vec_2, vec_3, col)

cpdef void rect(int pos_x, int pos_y, int width, int height, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    DrawRectangle(pos_x, pos_y, width, height, col)

cpdef void rect_vec(pos: Vector2Like, size: Vector2Like, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef vector2_t vec_pos = parse_vector2_like(pos)
    cdef vector2_t vec_size = parse_vector2_like(size)
    DrawRectangleV(vec_pos, vec_size, col)

cpdef void rect_rec(rect: RectLike, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef Rectangle rect_struct = parse_rect_like(rect)
    DrawRectangleRec(rect_struct, col)

cpdef void rect_pro(rect: RectLike, origin: Vector2Like, float rotation = 0.0, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef Rectangle rect_struct = parse_rect_like(rect)
    cdef vector2_t vec_origin = parse_vector2_like(origin)
    DrawRectanglePro(rect_struct, vec_origin, rotation, col)

cpdef void rect_gradient_vertical(int pos_x, int pos_y, int width, int height, top_color: ColorLike, bottom_color: ColorLike):
    cdef RlColor bottom_col = parse_color_like(bottom_color)
    cdef RlColor top_col = parse_color_like(top_color)
    DrawRectangleGradientV(pos_x, pos_y, width, height, top_col, bottom_col)

cpdef void rect_gradient_horizontal(int pos_x, int pos_y, int width, int height, left_color: ColorLike, right_color: ColorLike):
    cdef RlColor right_col = parse_color_like(right_color)
    cdef RlColor left_col = parse_color_like(left_color)
    DrawRectangleGradientH(pos_x, pos_y, width, height, left_col, right_col)

cpdef void rect_gradient_ex(rect: RectLike, col_1: ColorLike, col_2: ColorLike, col_3: ColorLike, col_4: ColorLike):
    cdef RlColor col_1_struct = parse_color_like(col_1)
    cdef RlColor col_2_struct = parse_color_like(col_2)
    cdef RlColor col_3_struct = parse_color_like(col_3)
    cdef RlColor col_4_struct = parse_color_like(col_4)
    cdef Rectangle rect_struct = parse_rect_like(rect)
    DrawRectangleGradientEx(rect_struct, col_1_struct, col_2_struct, col_3_struct, col_4_struct)

cpdef void rect_lines(int pos_x, int pos_y, int width, int height, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    DrawRectangleLines(pos_x, pos_y, width, height, col)

cpdef void rect_lines_ex(rect: RectLike, float thickness = 1.0, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef Rectangle rect_struct = parse_rect_like(rect)
    DrawRectangleLinesEx(rect_struct, thickness, col)

cpdef void rounded_rect(rect: RectLike, float roundness = 0.2, int segments = 4, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef Rectangle rect_struct = parse_rect_like(rect)
    DrawRectangleRounded(rect_struct, roundness, segments, col)

cpdef void rounded_rect_lines(rect: RectLike, float roundness = 0.2, int segments = 4, float thickness = 1.0, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef Rectangle rect_struct = parse_rect_like(rect)
    DrawRectangleRoundedLines(rect_struct, roundness, segments, col)

cpdef void rounded_rect_lines_ex(rect: RectLike, float roundness = 0.2, int segments = 4, float thickness = 1.0, color: ColorLike = colors.White):
    cdef RlColor col = parse_color_like(color)
    cdef Rectangle rect_struct = parse_rect_like(rect)
    DrawRectangleRoundedLinesEx(rect_struct, roundness, segments, thickness, col)