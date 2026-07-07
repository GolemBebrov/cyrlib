import time

import pyray as rl

from nv_raylib import Rect, Vector2, Vector3, Vector4


def test_vector2():
    v = Vector2(10, 2)
    v2 = rl.Vector2(10, 2)

    times = 10000

    print("=== Vector2 access ===")
    t1 = time.time()
    for i in range(times):
        v.x
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        v2.x
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector2 creation")
    t1 = time.time()
    for i in range(times):
        Vector2()
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        rl.Vector2()
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector2 to tuple ===")
    t1 = time.time()
    for i in range(times):
        v.get_tuple()
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        (v2.x, v2.y)
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector2 Dot ===")
    t1 = time.time()
    for i in range(times):
        v.dot(v)
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    dot = rl.vector2_dot_product
    for i in range(times):
        dot(v2, v2)
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector2 Minus ===")
    t1 = time.time()
    for i in range(times):
        v - v
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        rl.vector2_subtract(v2, v2)
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        Vector2(v2.x - v2.y, v2.y - v2.x)
    t2 = time.time()
    print(f"pyray variant: {t2 - t1:.6f}")

    print("=== basic math ===")
    t1 = time.time()
    for i in range(times):
        v.x - v.x
        v.y - v.y
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        v2.x - v2.x
        v2.y - v2.y
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector2 Round ===")
    t1 = time.time()
    for i in range(times):
        v.get_round()
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        Vector2(round(v2.x), round(v2.y))
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")


def test_vector3():
    v = Vector3(10, 2, 5)
    v2 = rl.Vector3(10, 2, 5)

    times = 10000

    print("=== Vector3 access ===")
    t1 = time.time()
    for i in range(times):
        v.x
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        v2.x
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector3 to tuple ===")
    t1 = time.time()
    for i in range(times):
        v.get_tuple()
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        (v2.x, v2.y, v2.z)
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector3 Dot ===")
    t1 = time.time()
    for i in range(times):
        v.dot(v)
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    dot = rl.vector3_dot_product
    for i in range(times):
        dot(v2, v2)
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector3 Cross ===")
    t1 = time.time()
    for i in range(times):
        v.cross(v)
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    cross = rl.vector3_cross_product
    for i in range(times):
        cross(v2, v2)
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector3 Minus ===")
    t1 = time.time()
    for i in range(times):
        v - v
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        rl.vector3_subtract(v2, v2)
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        Vector3(v2.x - v2.y, v2.y - v2.z, v2.z - v2.x)
    t2 = time.time()
    print(f"pyray variant: {t2 - t1:.6f}")

    print("=== basic math ===")
    t1 = time.time()
    for i in range(times):
        v.x - v.x
        v.y - v.y
        v.z - v.z
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        v2.x - v2.x
        v2.y - v2.y
        v2.z - v2.z
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector3 Round ===")
    t1 = time.time()
    for i in range(times):
        v.get_round()
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        Vector3(round(v2.x), round(v2.y), round(v2.z))
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")


def test_vector4():
    v = Vector4(10, 2, 5, 1)
    v2 = rl.Vector4(10, 2, 5, 1)

    times = 10000

    print("=== Vector4 access ===")
    t1 = time.time()
    for i in range(times):
        v.x
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        v2.x
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector4 to tuple ===")
    t1 = time.time()
    for i in range(times):
        v.get_tuple()
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        (v2.x, v2.y, v2.z, v2.w)
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector4 Dot ===")
    t1 = time.time()
    for i in range(times):
        v.dot(v)
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    dot = rl.vector4_dot_product
    for i in range(times):
        dot(v2, v2)
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector4 Minus ===")
    t1 = time.time()
    for i in range(times):
        v - v
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        rl.vector4_subtract(v2, v2)
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        Vector4(v2.x - v2.y, v2.y - v2.z, v2.z - v2.w, v2.w - v2.x)
    t2 = time.time()
    print(f"pyray variant: {t2 - t1:.6f}")

    print("=== basic math ===")
    t1 = time.time()
    for i in range(times):
        v.x - v.x
        v.y - v.y
        v.z - v.z
        v.w - v.w
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        v2.x - v2.x
        v2.y - v2.y
        v2.z - v2.z
        v2.w - v2.w
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")

    print("=== Vector4 Round ===")
    t1 = time.time()
    for i in range(times):
        v.get_round()
    t2 = time.time()
    print(f"nv_raylib: {t2 - t1:.6f}")
    t1 = time.time()
    for i in range(times):
        Vector4(round(v2.x), round(v2.y), round(v2.z), round(v2.w))
    t2 = time.time()
    print(f"pyray: {t2 - t1:.6f}")


def test_rect():
    rect = Rect(10, 20, 30, 40)
    times = 10000
    print("=== Rect Collide Point ===")
    pos = Vector2(40, 60)
    t1 = time.time()
    for i in range(times):
        rect.collide_point(pos)
    t2 = time.time()
    print(f"result: {rect.collide_point(pos)}, time: {t2 - t1:.6f} ")


TEST_VECTORS = False
TEST_RECT = True
if TEST_VECTORS:
    test_vector2()
    test_vector3()
    test_vector4()
if TEST_RECT:
    test_rect()
