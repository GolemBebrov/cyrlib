from cyrlib.raylib.raylib cimport (
    Music as music_t,
    LoadMusicStream,
    IsMusicValid,
    UpdateMusicStream,
    UnloadMusicStream,
    PlayMusicStream,
    StopMusicStream,
    PauseMusicStream,
    ResumeMusicStream,
    IsMusicStreamPlaying,
    SetMusicVolume,
    SetMusicPitch,
    SetMusicPan,
    SeekMusicStream,
    GetMusicTimePlayed,
    GetMusicTimeLength
)

from cyrlib.audio_stream.audio_stream cimport AudioStream

cdef class Music:
    cdef music_t raw
    cdef public AudioStream stream
    cdef float _volume
    cdef float _pitch
    cdef float _pan

    def __dealloc__(self):
        if self.valid:
            self.c_unload()

    def __len__(self):
        return round(self.length)

    @staticmethod
    cdef inline Music new(music_t struct):
        music = Music()
        music.raw = struct
        music.stream = AudioStream.cfrom_struct(music.raw.stream)
        music._volume = 1.0
        music._pitch = 1.0
        music._pan = 0.0
        return music

    @staticmethod
    cdef inline Music c_load(str filename):
        raw = LoadMusicStream(filename.encode("utf-8"))
        return Music.new(raw)

    cdef inline void c_unload(self):
        UnloadMusicStream(self.raw)

    cpdef void play(self):
        PlayMusicStream(self.raw)

    cpdef void stop(self):
        StopMusicStream(self.raw)

    cpdef void pause(self):
        PauseMusicStream(self.raw)

    cpdef void resume(self):
        ResumeMusicStream(self.raw)

    cpdef void update(self):
        UpdateMusicStream(self.raw)

    cpdef void seek(self, float position):
        SeekMusicStream(self.raw, position)

    def unload(self):
        self.c_unload()

    @staticmethod
    def load(str filename) -> Music:
        return Music.c_load(filename)

    @property
    def valid(self) -> bool:
        return IsMusicValid(self.raw)

    @property
    def looping(self) -> bool:
        return self.raw.looping

    @looping.setter
    def looping(self, bool value):
        self.raw.looping = value

    @property
    def volume(self) -> float:
        return self._volume

    @volume.setter
    def volume(self, float value):
        self._volume = value
        SetMusicVolume(self.raw, value)

    @property
    def pitch(self) -> float:
        return self._pitch

    @pitch.setter
    def pitch(self, float value):
        self._pitch = value
        SetMusicPitch(self.raw, value)

    @property
    def pan(self) -> float:
        return self._pan

    @pan.setter
    def pan(self, float value):
        self._pan = value
        SetMusicPan(self.raw, value)

    @property
    def length(self) -> float:
        return GetMusicTimeLength(self.raw)

    @property
    def time_played(self) -> float:
        return GetMusicTimePlayed(self.raw)
