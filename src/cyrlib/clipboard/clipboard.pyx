from cyrlib.raylib.raylib cimport (
    SetClipboardText, GetClipboardText, GetClipboardImage
)

cdef inline void c_set_text(str text):
    SetClipboardText(text.encode("utf-8"))

cdef inline str c_get_text():
    cdef text = <bytes>GetClipboardText()
    return text.decode("utf-8")

cpdef void set_text(str text):
    c_set_text(text)

cpdef str get_text():
    return c_get_text()

# TODO: Image cdef class
#cdef inline Image GetClipboardImage():
#   return Image.new(GetClipboardImage())
