from cyrlib.raylib.raylib cimport (
    AudioStream as audio_stream_t,
    LoadAudioStream,
    UnloadAudioStream,
    IsAudioStreamValid,
    UpdateAudioStream,
    IsAudioStreamProcessed,
    PlayAudioStream,
    PauseAudioStream,
    ResumeAudioStream,
    IsAudioStreamPlaying,
    StopAudioStream,
    SetAudioStreamVolume,
    SetAudioStreamPitch,
    SetAudioStreamPan
)

from cpython.buffer cimport PyObject_GetBuffer, PyBuffer_Release, PyBUF_SIMPLE, Py_buffer

cdef class AudioStream:
    @staticmethod
    cdef inline AudioStream cfrom_struct(audio_stream_t struct, bint is_owner=True):
        cdef AudioStream stream = AudioStream.__new__(AudioStream)
        stream._raw = struct
        stream._is_owner = is_owner
        stream._volume = 1.0
        stream._pitch = 1.0
        stream._pan = 0.5
        return stream

    @staticmethod
    cdef AudioStream new(int sample_rate, int sample_size, int channels):
        cdef AudioStream stream = AudioStream.__new__(AudioStream)
        stream._raw = LoadAudioStream(<unsigned int>sample_rate, <unsigned int>sample_size, <unsigned int>channels)
        stream._is_owner = True
        stream._volume = 1.0
        stream._pitch = 1.0
        stream._pan = 0.5
        return stream

    def __init__(self, int sample_rate, int sample_size, int channels):
        self._raw = LoadAudioStream(<unsigned int>sample_rate, <unsigned int>sample_size, <unsigned int>channels)
        self._is_owner = True
        self._volume = 1.0
        self._pitch = 1.0
        self._pan = 0.5

    def __dealloc__(self):
        if self._is_owner:
            self.c_unload()

    cdef inline void c_unload(self):
        if self._raw.buffer != NULL:
            UnloadAudioStream(self._raw)
            self._raw.buffer = NULL

    def unload(self):
        self.c_unload()

    @property
    def valid(self) -> bool:
        return self._raw.buffer != NULL and IsAudioStreamValid(self._raw)

    def update(self, object data, int frame_count):
        cdef Py_buffer py_buf

        if PyObject_GetBuffer(data, &py_buf, PyBUF_SIMPLE) != 0:
            raise TypeError("Object does not support the Python buffer protocol")

        try:
            UpdateAudioStream(self._raw, <const void*>py_buf.buf, frame_count)
        finally:
            PyBuffer_Release(&py_buf)

    def play(self):
        PlayAudioStream(self._raw)

    def pause(self):
        PauseAudioStream(self._raw)

    def resume(self):
        ResumeAudioStream(self._raw)

    def stop(self):
        StopAudioStream(self._raw)

    @property
    def processed(self) -> bool:
        return IsAudioStreamProcessed(self._raw)

    @property
    def playing(self) -> bool:
        return IsAudioStreamPlaying(self._raw)

    @property
    def volume(self) -> float:
        return self._volume

    @volume.setter
    def volume(self, float value):
        self._volume = value
        SetAudioStreamVolume(self._raw, value)

    @property
    def pitch(self) -> float:
        return self._pitch

    @pitch.setter
    def pitch(self, float value):
        self._pitch = value
        SetAudioStreamPitch(self._raw, value)

    @property
    def pan(self) -> float:
        return self._pan

    @pan.setter
    def pan(self, float value):
        self._pan = value
        SetAudioStreamPan(self._raw, value)
