from cyrlib.raylib.raylib cimport (
    InitAudioDevice,
    CloseAudioDevice,
    IsAudioDeviceReady,
    SetMasterVolume,
    GetMasterVolume
)

cdef class Audio:
    def init(self) -> None:
        InitAudioDevice()

    def close(self) -> None:
        CloseAudioDevice()

    @property
    def ready(self) -> bool:
        return IsAudioDeviceReady()

    @property
    def master_volume(self) -> float:
        return GetMasterVolume()

    @master_volume.setter
    def master_volume(self, float volume) -> None:
        SetMasterVolume(volume)


audio = Audio()
