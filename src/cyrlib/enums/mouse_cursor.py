from enum import IntEnum


class MouseCursor(IntEnum):
    Default = 0
    Arrow = 1
    Ibeam = 2
    Crosshair = 3
    PointingHand = 4
    ResizeEw = 5
    ResizeNs = 6
    ResizeNwse = 7
    ResizeNesw = 8
    ResizeAll = 9
    NotAllowed = 10
