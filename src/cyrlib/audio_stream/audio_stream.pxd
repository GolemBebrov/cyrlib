from cyrlib.raylib.raylib cimport AudioStream as audio_stream_t

cdef class AudioStream:
    cdef audio_stream_t _raw
    cdef bint _is_owner
    cdef float _volume
    cdef float _pitch
    cdef float _pan

    @staticmethod
    cdef inline AudioStream cfrom_struct(audio_stream_t struct, bint is_owner=*)

    @staticmethod
    cdef AudioStream new(int sample_rate, int sample_size, int channels)
    cdef inline void c_unload(self)
