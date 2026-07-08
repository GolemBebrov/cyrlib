from nv_raylib.raylib.raylib cimport (
    InitWindow, CloseWindow, SetTargetFPS, GetScreenWidth,
    GetScreenHeight, SetWindowSize, SetWindowTitle, SetConfigFlags,
    SetExitKey, IsWindowState, SetWindowState, ClearWindowState,
    MinimizeWindow, MaximizeWindow, RestoreWindow, ToggleFullscreen,
    BeginDrawing, EndDrawing, WindowShouldClose,
)
from nv_raylib.vector2.vector2 cimport Vector2
from nv_raylib.enums import WindowFlags
from contextlib import contextmanager


cdef class Window:
    cdef Vector2 _size
    cdef str _title
    cdef int _flags

    def __cinit__(self, *args, **kwargs):
        self._size = Vector2(0, 0)
        self._title = ""
        self._flags = 0

    def __init__(self, int width, int height, str title, int flags = 0):
        self._flags = flags
        self._title = title

        if flags != 0:
            SetConfigFlags(flags)

        InitWindow(width, height, title.encode('utf-8'))
        self._size = Vector2(width, height)

    @contextmanager
    def drawing(self):
        self.begin_drawing()
        try:
            yield
        finally:
            self.end_drawing()

    @property
    def should_close(self):
        return WindowShouldClose()

    cpdef void close(self):
        CloseWindow()

    cdef inline int get_width(self) noexcept:
        return GetScreenWidth()

    cdef inline void set_width(self, int value) noexcept:
        SetWindowSize(value, GetScreenHeight())

    cdef inline int get_height(self) noexcept:
        return GetScreenHeight()

    cdef inline void set_height(self, int value) noexcept:
        SetWindowSize(GetScreenWidth(), value)

    cpdef void begin_drawing(self) noexcept:
        BeginDrawing()

    cpdef void end_drawing(self) noexcept:
        EndDrawing()

    @property
    def width(self) -> int:
        return self.get_width()

    @width.setter
    def width(self, value):
        self.set_width(value)

    @property
    def height(self) -> int:
        return self.get_height()

    @height.setter
    def height(self, value):
        self.set_height(value)

    cdef inline void set_title(self, str value) noexcept:
        self._title = value
        SetWindowTitle(value.encode('utf-8'))

    @property
    def title(self) -> str:
        return self._title

    @title.setter
    def title(self, value):
        self.set_title(value)

    @property
    def size(self) -> Vector2:
        self._size.x = GetScreenWidth()
        self._size.y = GetScreenHeight()
        return self._size

    @size.setter
    def size(self, value):
        SetWindowSize(int(value.x), int(value.y))

    @property
    def fullscreen(self) -> bool:
        return self.is_fullscreen()

    @fullscreen.setter
    def fullscreen(self, bint value):
        if value != self.is_fullscreen():
            ToggleFullscreen()

    @property
    def maximized(self) -> bool:
        return self.is_maximized()

    @maximized.setter
    def maximized(self, bint value):
        if value:
            MaximizeWindow()
        else:
            RestoreWindow()

    @property
    def minimized(self) -> bool:
        return self.is_minimized()

    @minimized.setter
    def minimized(self, bint value):
        if value:
            MinimizeWindow()
        else:
            RestoreWindow()

    cpdef bint is_fullscreen(self):
        return self.is_state(WindowFlags.Fullscreen)

    cpdef bint is_maximized(self):
        return self.is_state(WindowFlags.Maximized)

    cpdef bint is_minimized(self):
        return self.is_state(WindowFlags.Minimized)

    cpdef bint is_state(self, int state):
        return IsWindowState(state)
