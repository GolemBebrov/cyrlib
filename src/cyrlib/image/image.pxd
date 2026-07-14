from cyrlib.raylib.raylib cimport Image as image_t

cdef class Image:
    cdef image_t _raw

    @staticmethod
    cdef Image new(image_t rl_image)

    @staticmethod
    cdef Image c_load(str file_name)

    @staticmethod
    cdef Image c_load_raw(str file_name, int width, int height, int format, int header_size)

    @staticmethod
    cdef Image c_load_anim(str file_name, int * frames)

    @staticmethod
    cdef Image c_load_from_screen()

    cdef Image c_copy(self)

    cpdef bint export(self, str file_name)

    cpdef void unload(self)

    cpdef Image copy(self)

    cpdef Image from_channel(self, int selected_channel)
