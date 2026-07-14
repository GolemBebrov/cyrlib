from enum import IntEnum


class TextureFilter(IntEnum):
    Point = 0
    Bilinear = 1
    Trilinear = 2
    Anisotropic_4X = 3
    Anisotropic_8X = 4
    Anisotropic_16X = 5
