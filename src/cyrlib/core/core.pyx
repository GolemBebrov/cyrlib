from cyrlib.raylib.raylib cimport (
    InitWindow, CloseWindow, SetTargetFPS, GetScreenWidth,
    GetScreenHeight, SetWindowSize, SetWindowTitle, SetConfigFlags,
    SetExitKey, IsWindowState, SetWindowState, ClearWindowState,
    MinimizeWindow, MaximizeWindow, RestoreWindow, ToggleFullscreen,
    BeginDrawing, EndDrawing, WindowShouldClose, IsWindowReady,
    IsWindowFullscreen, IsWindowHidden, IsWindowMinimized, IsWindowMaximized,
    IsWindowFocused, IsWindowResized, SetWindowPosition, SetWindowMonitor,
    SetWindowMinSize, SetWindowMaxSize, SetWindowOpacity, SetWindowFocused,
    GetWindowHandle, GetRenderWidth, GetRenderHeight, GetWindowPosition,
    GetWindowScaleDPI
)
from cyrlib.vector2.vector2 cimport Vector2
from cyrlib.enums import WindowFlags
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

    cdef inline bint is_ready(self) noexcept:
        return IsWindowReady()

    cdef inline bint is_fullscreen(self) noexcept:
        return IsWindowFullscreen()

    cdef inline bint is_hidden(self) noexcept:
        return IsWindowHidden()

    cdef inline bint is_maximized(self) noexcept:
        return IsWindowMaximized()

    cdef inline bint is_minimized(self) noexcept:
        return IsWindowMinimized()

    cdef inline bint is_focused(self) noexcept:
        return IsWindowFocused()

    cdef inline bint is_resized(self) noexcept:
        return IsWindowResized()

    # TODO: Image cdef class
    #cdef inline void set_icon(self, Image image) noexcept:
    #    SetWindowIcon(image)
    #cdef inline void set_icons(self, Image * images, int count) noexcept:
    #    SetWindowIcons(images, count)

    cdef inline void set_title(self, str title) noexcept:
        SetWindowTitle(title.encode('utf-8'))

    cdef inline void set_position(self, int x, int y) noexcept:
        SetWindowPosition(x, y)

    cdef inline void set_monitor(self, int monitor) noexcept:
        SetWindowMonitor(monitor)

    cdef inline void set_minsize(self, int width, int height) noexcept:
        SetWindowMinSize(width, height)

    cdef inline void set_maxsize(self, int width, int height) noexcept:
        SetWindowMaxSize(width, height)

    cdef inline void set_size(self, int width, int height) noexcept:
        SetWindowSize(width, height)

    cdef inline void set_width(self, int width) noexcept:
        SetWindowSize(width, self.get_height())

    cdef inline void set_height(self, int height) noexcept:
        SetWindowSize(self.get_width(), height)

    cdef inline void set_opacity(self, double opacity) noexcept:
        SetWindowOpacity(opacity)

    cdef inline void set_focused(self) noexcept:
        SetWindowFocused()

    cdef inline void * get_handle(self) noexcept:
        return GetWindowHandle()

    cdef inline int get_width(self) noexcept:
        return GetScreenWidth()

    cdef inline int get_height(self) noexcept:
        return GetScreenHeight()

    cdef inline int get_render_width(self) noexcept:
        return GetRenderWidth()

    cdef inline int get_render_height(self) noexcept:
        return GetRenderHeight()

    cdef inline Vector2 get_position(self) noexcept:
        return Vector2.cfrom_struct(GetWindowPosition())

    cdef inline Vector2 get_DPI_scale(self) noexcept:
        return Vector2.cfrom_struct(GetWindowScaleDPI())

    cdef inline void begin_drawing(self) noexcept:
        BeginDrawing()

    cdef inline void end_drawing(self) noexcept:
        EndDrawing()

    cpdef bint is_state(self, int flag):
        return IsWindowState(flag)

    cpdef void set_state(self, int flags):
        SetWindowState(<unsigned int>flags)

    cpdef void clear_state(self, int flags):
        ClearWindowState(<unsigned int>flags)

    cpdef void close(self):
        CloseWindow()

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

    @property
    def title(self) -> str:
        return self._title

    @title.setter
    def title(self, value):
        self.set_title(value)
        self._title = value

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

    @contextmanager
    def drawing(self):
        self.begin_drawing()
        try:
            yield
        finally:
            self.end_drawing()

    @property
    def should_close(self) -> bint:
        return WindowShouldClose()
