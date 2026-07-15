from cyrlib.raylib.raylib cimport (
    IsMouseButtonPressed,
    IsMouseButtonReleased,
    IsMouseButtonDown,
    IsMouseButtonUp,
    SetMousePosition,
    SetMouseOffset,
    SetMouseScale,
    GetMouseWheelMove,
    GetMouseWheelMoveV,
    SetMouseCursor,
    GetMouseX,
    GetMouseY,
    GetMousePosition,
    GetMouseDelta,
    Vector2 as vector2_t
)

from cyrlib.vector2.vector2 cimport Vector2

cdef class Mouse:
    cdef int _cursor
    cdef Vector2 _offset, _scale
    def __init__(self):
        self._cursor = 0
        self._offset = Vector2.new(0, 0)
        self._scale = Vector2.new(1, 1)

    cpdef bint pressed(self, int button):
        return IsMouseButtonPressed(button)

    cpdef bint released(self, int button):
        return IsMouseButtonReleased(button)

    cpdef bint down(self, int button):
        return IsMouseButtonDown(button)

    cpdef bint up(self, int button):
        return IsMouseButtonUp(button)

    cpdef void set_offset(self, int x, int y):
        self._offset = Vector2.new(x, y)
        SetMouseOffset(x, y)

    cpdef void set_scale(self, float x, float y):
        self._scale = Vector2.new(x, y)
        SetMouseScale(x, y)

    @property
    def offset(self) -> Vector2:
        return self._offset

    @offset.setter
    def offset(self, Vector2 offset):
        self._offset = offset
        SetMouseOffset(offset.x, offset.y)

    @property
    def scale(self) -> Vector2:
        return self._scale

    @scale.setter
    def scale(self, Vector2 scale):
        self._scale = scale
        SetMouseScale(scale.x, scale.y)

    @property
    def wheel_move(self) -> float:
        return GetMouseWheelMove()

    @property
    def wheel_move_vec(self) -> Vector2:
        cdef vector2_t wheel_move = GetMouseWheelMoveV()
        return Vector2.new(wheel_move.x, wheel_move.y)

    @property
    def cursor(self) -> int:
        return self._cursor

    @cursor.setter
    def cursor(self, int cursor):
        self._cursor = cursor
        SetMouseCursor(cursor)

    @property
    def x(self) -> int:
        return GetMouseX()

    @property
    def y(self) -> int:
        return GetMouseY()

    @property
    def position(self) -> Vector2:
        cdef vector2_t pos = GetMousePosition()
        return Vector2.new(pos.x, pos.y)

    @position.setter
    def position(self, Vector2 pos):
        SetMousePosition(pos.x, pos.y)

    @property
    def delta(self) -> Vector2:
        cdef vector2_t delta = GetMouseDelta()
        return Vector2.new(delta.x, delta.y)

mouse = Mouse()
