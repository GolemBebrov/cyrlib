from cyrlib.raylib.raylib cimport (
    ShowCursor, HideCursor, IsCursorHidden,
    EnableCursor, DisableCursor, IsCursorOnScreen
)

cdef bint cursor_enabled = True

cdef class Cursor:

    cdef inline void c_enable(self) noexcept:
        global cursor_enabled
        cursor_enabled = True
        EnableCursor()

    cdef inline void c_disable(self) noexcept:
        global cursor_enabled
        cursor_enabled = False
        DisableCursor()

    cdef inline void c_show(self) noexcept:
        ShowCursor()

    cdef inline void c_hide(self) noexcept:
        HideCursor()

    cpdef void enable(self):
        self.c_enable()

    cpdef void disable(self):
        self.c_disable()

    cpdef void show(self):
        self.c_show()

    cpdef void hide(self):
        self.c_hide()

    @property
    def on_screen(self) -> bool:
        IsCursorOnScreen()

    @property
    def enabled(self) -> bool:
        return cursor_enabled

    @property
    def hidden(self) -> bool:
        return IsCursorHidden()

cursor = Cursor()
