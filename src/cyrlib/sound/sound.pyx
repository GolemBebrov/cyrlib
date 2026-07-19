from cyrlib.raylib.raylib cimport (
    Sound as sound_t,
    LoadSound,
    LoadSoundAlias,
    IsSoundValid,
    UpdateSound,
    UnloadSound,
    UnloadSoundAlias,
    PlaySound,
    StopSound,
    PauseSound,
    ResumeSound,
    IsSoundPlaying,
    SetSoundVolume,
    SetSoundPitch,
    SetSoundPan
)

from cpython.buffer cimport PyObject_GetBuffer, PyBuffer_Release, PyBUF_SIMPLE, Py_buffer

from cyrlib.audio_stream.audio_stream cimport AudioStream

cdef class Sound:
    cdef sound_t _raw
    cdef bint _is_alias
    cdef float _volume
    cdef float _pitch
    cdef float _pan
    cdef AudioStream _stream

    @staticmethod
    cdef Sound new(sound_t struct, bint is_alias=False):
        cdef Sound sound = Sound.__new__(Sound)
        sound._raw = struct
        sound._is_alias = is_alias
        sound._volume = 1.0
        sound._pitch = 1.0
        sound._pan = 0.5
        sound._stream = AudioStream.cfrom_struct(struct.stream)
        return sound

    def __dealloc__(self):
        self.c_unload()

    cdef inline void c_unload(self):
        if self._raw.stream.buffer != NULL:
            if self._is_alias:
                UnloadSoundAlias(self._raw)
            else:
                UnloadSound(self._raw)
            self._raw.stream.buffer = NULL

    def unload(self):
        self.c_unload()

    @staticmethod
    def load(str file_name) -> Sound:
        cdef bytes file_name_bytes = file_name.encode("utf-8")
        return Sound.new(LoadSound(file_name_bytes), False)

    @staticmethod
    def load_alias(Sound source) -> Sound:
        return Sound.new(LoadSoundAlias(source._raw), True)

    @property
    def valid(self) -> bool:
        return self._raw.stream.buffer != NULL and IsSoundValid(self._raw)

    @property
    def is_alias(self) -> bool:
        return self._is_alias

    @property
    def frame_count(self) -> int:
        return self._raw.frameCount

    @property
    def stream(self) -> AudioStream:
        return self._stream

    def update(self, object data, int frame_count):
        cdef Py_buffer py_buf

        if PyObject_GetBuffer(data, &py_buf, PyBUF_SIMPLE) != 0:
            raise TypeError("Object does not support the Python buffer protocol")

        try:
            UpdateSound(self._raw, <const void*>py_buf.buf, frame_count)
        finally:
            PyBuffer_Release(&py_buf)

    def play(self):
        PlaySound(self._raw)

    def stop(self):
        StopSound(self._raw)

    def pause(self):
        PauseSound(self._raw)

    def resume(self):
        ResumeSound(self._raw)

    @property
    def playing(self) -> bool:
        return IsSoundPlaying(self._raw)

    @property
    def volume(self) -> float:
        return self._volume

    @volume.setter
    def volume(self, float value):
        self._volume = value
        SetSoundVolume(self._raw, value)

    @property
    def pitch(self) -> float:
        return self._pitch

    @pitch.setter
    def pitch(self, float value):
        self._pitch = value
        SetSoundPitch(self._raw, value)

    @property
    def pan(self) -> float:
        return self._pan

    @pan.setter
    def pan(self, float value):
        self._pan = value
        SetSoundPan(self._raw, value)
