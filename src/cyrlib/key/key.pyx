from cyrlib.raylib.raylib cimport (
    IsKeyPressed,
    IsKeyReleased,
    IsKeyPressedRepeat,
    IsKeyDown,
    IsKeyUp,
)

cpdef bint pressed(int key):
    return IsKeyPressed(key)

cpdef bint released(int key):
    return IsKeyReleased(key)

cpdef bint pressed_repeat(int key):
    return IsKeyPressedRepeat(key)

cpdef bint down(int key):
    return IsKeyDown(key)

cpdef bint up(int key):
    return IsKeyUp(key)
