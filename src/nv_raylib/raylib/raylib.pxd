cdef extern from "raylib.h" nogil:
    void InitWindow(int width, int height, const char *title) noexcept
    void CloseWindow() noexcept
    struct Color:
        unsigned char r
        unsigned char g
        unsigned char b
        unsigned char a
    bint WindowShouldClose() noexcept
    void SetTargetFPS(int fps) noexcept
    int GetScreenWidth() noexcept
    int GetScreenHeight() noexcept
    void SetWindowSize(int width, int height) noexcept
    void SetWindowTitle(const char *title) noexcept
    void SetConfigFlags(unsigned int flags) noexcept
    void SetExitKey (int key) noexcept
    bint IsWindowState(unsigned int flag) noexcept
    void ToggleFullscreen() noexcept
    void MaximizeWindow() noexcept
    void MinimizeWindow() noexcept
    void RestoreWindow() noexcept
    void SetWindowState(unsigned int flag) noexcept
    void ClearWindowState(unsigned int flag) noexcept
    void BeginDrawing() noexcept
    void EndDrawing() noexcept
    void DrawFPS(int x, int y) noexcept
    void ClearBackground(Color color) noexcept
