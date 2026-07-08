from enum import IntFlag


class WindowFlags(IntFlag):
    VSync = 64
    Fullscreen = 2
    Resizable = 4
    Undecorated = 8
    Hidden = 128
    Minimized = 512
    Maximized = 1024
    Unfocused = 2048
    Topmost = 4096
    AlwaysRun = 256
    Transparent = 16
    HighDPI = 8192
    MousePassthrough = 16384
    BorderlessWindowedMode = 32768
    MSAA4XHint = 32
    InterlacedHint = 65536
