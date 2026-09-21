from cyrlib.vector2.vector2 cimport vector2_t, Vector2, vector2_new
from cyrlib.color.color cimport RlColor, Color, color_new
from cyrlib.rect.rect cimport Rect, Rectangle, rectangle_new
from cpython.sequence cimport PySequence_Check, PySequence_Fast, PySequence_Fast_GET_ITEM, PySequence_Fast_GET_SIZE
from cpython.ref cimport PyObject

cdef extern from "Python.h":
    bint PyNumber_Check(PyObject *p)
    double PyFloat_AsDouble(PyObject *p)

cdef inline vector2_t parse_vector2_like(object dest) except *:
    # === FAST PATH ===
    if type(dest) is Vector2: return (<Vector2>dest).data
    
    # === MEDIUM PATHS ===
    if type(dest) is tuple:
        if len(<tuple>dest) != 2:
            raise ValueError("tuple for vector2-like argument must have only 2 elements.")
        return vector2_new(<double>(<tuple>dest)[0], <double>(<tuple>dest)[1])
    
    if type(dest) is list:
        if len(<list>dest) != 2:
            raise ValueError("list for vector2-like argument must have only 2 elements.")
        return vector2_new(<double>(<list>dest)[0], <double>(<list>dest)[1])
    
    # === SLOW PATH ===
    if PySequence_Check(dest):
        fast_seq = PySequence_Fast(dest, <char*>"expected sequence")
        if PySequence_Fast_GET_SIZE(fast_seq) != 2:
            raise ValueError("sequence for vector2-like argument must have only 2 elements.")
        return vector2_new(PyFloat_AsDouble(PySequence_Fast_GET_ITEM(fast_seq, 0)), PyFloat_AsDouble(PySequence_Fast_GET_ITEM(fast_seq, 1)))
    
    raise TypeError(f"vector2-like argument must be Vector2, or any sequence, got {type(dest).__name__}.")

cdef inline RlColor parse_color_like(object color) except *:
    # === FAST PATH ===
    if type(color) is Color: return (<Color>color)._raw

    cdef Py_ssize_t color_len

    # === MEDIUM PATHS ===
    if type(color) is tuple:
        color_len = len(<tuple>color)
        if not (2 < color_len < 5):
            raise ValueError("tuple for color-like argument must have only 3-4 elements.")
        if color_len == 4:
            return color_new(<int>(<tuple>color)[0], <int>(<tuple>color)[1], <int>(<tuple>color)[2], <int>(<tuple>color)[3])
        else:
            return color_new(<int>(<tuple>color)[0], <int>(<tuple>color)[1], <int>(<tuple>color)[2], 255)

    if type(color) is list:
        color_len = len(<list>color)
        if not (2 < color_len < 5):
            raise ValueError("list for color-like argument must have only 3-4 elements.")
        if color_len == 4:
            return color_new(<int>(<list>color)[0], <int>(<list>color)[1], <int>(<list>color)[2], <int>(<list>color)[3])
        else:
            return color_new(<int>(<list>color)[0], <int>(<list>color)[1], <int>(<list>color)[2], 255)

    # === SLOW PATH ===
    if PySequence_Check(color):
        fast_seq = PySequence_Fast(color, <char*>"expected sequence")
        color_len = PySequence_Fast_GET_SIZE(fast_seq)
        if not (2 < color_len < 5):
            raise ValueError("sequence for color-like argument must have only 3-4 elements.")
        if color_len == 4:
            return color_new(
                <int><object>PySequence_Fast_GET_ITEM(fast_seq, 0),
                <int><object>PySequence_Fast_GET_ITEM(fast_seq, 1),
                <int><object>PySequence_Fast_GET_ITEM(fast_seq, 2),
                <int><object>PySequence_Fast_GET_ITEM(fast_seq, 3)
            )
        else:
            return color_new(
                <int><object>PySequence_Fast_GET_ITEM(fast_seq, 0),
                <int><object>PySequence_Fast_GET_ITEM(fast_seq, 1),
                <int><object>PySequence_Fast_GET_ITEM(fast_seq, 2),
                255
            )

    raise TypeError(f"color-like argument must be Color, or any sequence, got {type(color).__name__}.")

cdef inline Rectangle parse_rect_like(object rect) except *:
    # === FAST PATH ===
    if type(rect) is Rect: return (<Rect>rect)._raw

    # === MEDIUM PATHS ===
    if type(rect) is tuple:
        if len(<tuple>rect) != 4:
            raise ValueError("tuple for rect-like argument must have only 4 elements.")
        return rectangle_new(<float>(<tuple>rect)[0], <float>(<tuple>rect)[1], <float>(<tuple>rect)[2], <float>(<tuple>rect)[3])
    
    if type(rect) is list:
        if len(<list>rect) != 4:
            raise ValueError("list for rect-like argument must have only 4 elements.")
        return rectangle_new(<float>(<list>rect)[0], <float>(<list>rect)[1], <float>(<list>rect)[2], <float>(<list>rect)[3])
    
    # === SLOW PATH ===
    if PySequence_Check(rect):
        fast_seq = PySequence_Fast(rect, <char*>"expected sequence")
        if PySequence_Fast_GET_SIZE(fast_seq) != 4:
            raise ValueError("sequence for rect-like argument must have only 4 elements.")
        return rectangle_new(
            <float><object>PySequence_Fast_GET_ITEM(fast_seq, 0),
            <float><object>PySequence_Fast_GET_ITEM(fast_seq, 1),
            <float><object>PySequence_Fast_GET_ITEM(fast_seq, 2),
            <float><object>PySequence_Fast_GET_ITEM(fast_seq, 3)
        )

    raise TypeError(f"rect_like argument must be Rect, tuple, or list, got {type(rect).__name__}")
