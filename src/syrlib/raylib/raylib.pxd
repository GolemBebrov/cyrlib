cdef extern from "stdarg.h" nogil:
    ctypedef struct va_list:
        pass

cdef extern from "raylib.h" nogil:
    # === Structs ===
    struct Vector2:
        float x
        float y

    struct Vector3:
        float x
        float y
        float z

    struct Camera3D:
        Vector3 position
        Vector3 target
        Vector3 up
        float fovy
        int projection
    ctypedef Camera3D Camera
    struct Camera2D:
        Vector2 offset
        Vector2 target
        float rotation
        float zoom

    struct Vector4:
        float x
        float y
        float z
        float w

    ctypedef Vector4 Quaternion

    struct Matrix:
        float m0, m4, m8, m12
        float m1, m5, m9, m13
        float m2, m6, m10, m14
        float m3, m7, m11, m15

    struct Color:
        unsigned char r
        unsigned char g
        unsigned char b
        unsigned char a

    struct Rectangle:
        float x
        float y
        float width
        float height

    struct Image:
        void *data
        int width
        int height
        int mipmaps
        int format

    struct Texture:
        unsigned int id
        int width
        int height
        int mipmaps
        int format

    ctypedef Texture Texture2D
    ctypedef Texture TextureCubemap

    struct RenderTexture:
        unsigned int id
        Texture texture
        Texture depth

    ctypedef RenderTexture RenderTexture2D

    struct NPatchInfo:
        Rectangle source
        int left
        int top
        int right
        int bottom
        int layout

    struct GlyphInfo:
        int value
        int offsetX
        int offsetY
        int advanceX
        Image image

    struct Font:
        int baseSize
        int glyphCount
        int glyphPadding
        Texture texture
        Rectangle *recs
        GlyphInfo *glyphs

    struct Camera3D:
        Vector3 position
        Vector3 target
        Vector3 up
        float fovy
        int projection

    struct Camera2D:
        Vector2 offset
        Vector2 target
        float rotation
        float zoom

    struct Mesh:
        int vertexCount
        int triangleCount
        float *vertices
        float *texcoords
        float *texcoords2
        float *normals
        float *tangents
        unsigned char *colors
        unsigned short *indices
        int boneCount
        unsigned char *boneIndices
        float *boneWeights
        float *animVertices
        float *animNormals
        unsigned int vaoId
        unsigned int *vboId

    struct Shader:
        unsigned int id
        int *locs

    struct MaterialMap:
        Texture texture
        Color color
        float value

    struct Material:
        Shader shader
        MaterialMap *maps
        float params[4]

    struct Transform:
        Vector3 translation
        Quaternion rotation
        Vector3 scale
    ctypedef Transform *ModelAnimPose
    struct BoneInfo:
        char name[32]
        int parent

    struct ModelSkeleton:
        int boneCount
        BoneInfo *bones
        ModelAnimPose bindPose

    struct Model:
        Matrix transform
        int meshCount
        int materialCount
        Mesh *meshes
        Material *materials
        int *meshMaterial
        ModelSkeleton skeleton
        ModelAnimPose currentPose
        Matrix *boneMatrices

    struct ModelAnimation:
        char name[32]
        int boneCount
        int keyframeCount
        ModelAnimPose *keyframePoses

    struct Ray:
        Vector3 position
        Vector3 direction

    struct RayCollision:
        bint hit
        float distance
        Vector3 point
        Vector3 normal

    struct BoundingBox:
        Vector3 min
        Vector3 max

    struct Wave:
        unsigned int frameCount
        unsigned int sampleRate
        unsigned int sampleSize
        unsigned int channels
        void *data

    struct rAudioBuffer

    struct rAudioProcessor

    struct AudioStream:
        rAudioBuffer *buffer
        rAudioProcessor *processor
        unsigned int sampleRate
        unsigned int sampleSize
        unsigned int channels

    struct Sound:
        AudioStream stream
        unsigned int frameCount

    struct Music:
        AudioStream stream
        unsigned int frameCount
        bint looping
        int ctxType
        void *ctxData

    struct VrDeviceInfo:
        int hResolution
        int vResolution
        float hScreenSize
        float vScreenSize
        float eyeToScreenDistance
        float lensSeparationDistance
        float interpupillaryDistance
        float lensDistortionValues[4]
        float chromaAbCorrection[4]

    struct VrStereoConfig:
        Matrix projection[2]
        Matrix viewOffset[2]
        float leftLensCenter[2]
        float rightLensCenter[2]
        float leftScreenCenter[2]
        float rightScreenCenter[2]
        float scale[2]
        float scaleIn[2]

    struct FilePathList:
        unsigned int count
        char **paths

    struct AutomationEvent:
        unsigned int frame
        unsigned int type
        int params[4]

    struct AutomationEventList:
        unsigned int capacity
        unsigned int count
        AutomationEvent *events

    ctypedef void (*TraceLogCallback)(int logLevel, const char *text, va_list args)
    ctypedef unsigned char *(*LoadFileDataCallback)(const char *fileName, int *dataSize)
    ctypedef bool (*SaveFileDataCallback)(const char *fileName, void *data, int dataSize)
    ctypedef char *(*LoadFileTextCallback)(const char *fileName)
    ctypedef bool (*SaveFileTextCallback)(const char *fileName, const char *text)

    # === Window Functions ===
    void InitWindow(int width, int height, const char *title) noexcept
    void CloseWindow() noexcept
    bint WindowShouldClose() noexcept
    bint IsWindowReady() noexcept
    bint IsWindowFullscreen() noexcept
    bint IsWindowHidden() noexcept
    bint IsWindowMinimized() noexcept
    bint IsWindowMaximized() noexcept
    bint IsWindowFocused() noexcept
    bint IsWindowResized() noexcept
    bint IsWindowState(unsigned int flag) noexcept
    void SetWindowState(unsigned int flags) noexcept
    void ClearWindowState(unsigned int flags) noexcept
    void ToggleFullscreen() noexcept
    void ToggleBorderlessWindowed() noexcept
    void MaximizeWindow() noexcept
    void MinimizeWindow() noexcept
    void RestoreWindow() noexcept
    void SetWindowIcon(Image image) noexcept
    void SetWindowIcons(Image *images, int count) noexcept
    void SetWindowTitle(const char *title) noexcept
    void SetWindowPosition(int x, int y) noexcept
    void SetWindowMonitor(int monitor) noexcept
    void SetWindowMinSize(int width, int height) noexcept
    void SetWindowMaxSize(int width, int height) noexcept
    void SetWindowSize(int width, int height) noexcept
    void SetWindowOpacity(float opacity) noexcept
    void SetWindowFocused() noexcept
    void *GetWindowHandle() noexcept
    int GetScreenWidth() noexcept
    int GetScreenHeight() noexcept
    int GetRenderWidth() noexcept
    int GetRenderHeight() noexcept
    int GetMonitorCount() noexcept
    int GetCurrentMonitor() noexcept
    Vector2 GetMonitorPosition(int monitor) noexcept
    int GetMonitorWidth(int monitor) noexcept
    int GetMonitorHeight(int monitor) noexcept
    int GetMonitorPhysicalWidth(int monitor) noexcept
    int GetMonitorPhysicalHeight(int monitor) noexcept
    int GetMonitorRefreshRate(int monitor) noexcept
    Vector2 GetWindowPosition() noexcept
    Vector2 GetWindowScaleDPI() noexcept
    const char *GetMonitorName(int monitor) noexcept
    void SetClipboardText(const char *text) noexcept
    const char *GetClipboardText() noexcept
    Image GetClipboardImage() noexcept
    void EnableEventWaiting() noexcept
    void DisableEventWaiting() noexcept

    # === Cursor Related Functions ===
    void ShowCursor() noexcept
    void HideCursor() noexcept
    bint IsCursorHidden() noexcept
    void EnableCursor() noexcept
    void DisableCursor() noexcept
    bint IsCursorOnScreen() noexcept

    # === Drawing Functions ===
    void ClearBackground(Color color) noexcept
    void BeginDrawing() noexcept
    void EndDrawing() noexcept
    void BeginMode2D(Camera2D camera) noexcept
    void EndMode2D() noexcept
    void BeginMode3D(Camera3D camera) noexcept
    void EndMode3D() noexcept
    void BeginTextureMode(RenderTexture2D target) noexcept
    void EndTextureMode() noexcept
    void BeginShaderMode(Shader shader) noexcept
    void EndShaderMode() noexcept
    void BeginBlendMode(int mode) noexcept
    void EndBlendMode() noexcept
    void BeginScissorMode(int x, int y, int width, int height) noexcept
    void EndScissorMode() noexcept
    void BeginVrStereoMode(VrStereoConfig config) noexcept
    void EndVrStereoMode() noexcept
    VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device) noexcept
    void UnloadVrStereoConfig(VrStereoConfig config) noexcept

    # === Shader management functions ===
    Shader LoadShader(const char *vsFileName, const char *fsFileName) noexcept
    Shader LoadShaderFromMemory(const char *vsCode, const char *fsCode) noexcept
    bint IsShaderValid(Shader shader) noexcept
    int GetShaderLocation(Shader shader, const char *uniformName) noexcept
    int GetShaderLocationAttrib(Shader shader, const char *attribName) noexcept
    void SetShaderValue(Shader shader, int locIndex, const void *value, int uniformType) noexcept
    void SetShaderValueV(Shader shader, int locIndex, const void *value, int uniformType, int count) noexcept
    void SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat) noexcept
    void SetShaderValueTexture(Shader shader, int locIndex, Texture texture) noexcept
    void UnloadShader(Shader shader) noexcept

    # === Screen-Space related functions ===
    Ray GetScreenToWorldRay(Vector2 position, Camera camera) noexcept
    Ray GetScreenToWorldRayEx(Vector2 position, Camera camera, int width, int height) noexcept
    Vector2 GetWorldToScreen(Vector3 position, Camera camera) noexcept
    Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height) noexcept
    Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera) noexcept
    Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera) noexcept
    Matrix GetCameraMatrix(Camera camera) noexcept
    Matrix GetCameraMatrix2D(Camera2D camera) noexcept

    # === Timing-related functions ===
    void SetTargetFPS(int fps) noexcept
    float GetFrameTime() noexcept
    double GetTime() noexcept
    int GetFPS() noexcept

    # === Custom Frame Control functions ===
    void SwapScreenBuffer() noexcept
    void PollInputEvents() noexcept
    void WaitTime(double seconds) noexcept

    # === Random values generation functions ===
    void SetRandomSeed(unsigned int seed) noexcept
    int GetRandomValue(int min, int max) noexcept
    int *LoadRandomSequence(unsigned int count, int min, int max) noexcept
    void UnloadRandomSequence(int *sequence) noexcept

    # === Misc. functions ===
    void TakeScreenshot(const char *fileName) noexcept
    void SetConfigFlags(unsigned int flags) noexcept
    void OpenURL(const char *url) noexcept

    # === Logging system ===
    void SetTraceLogLevel(int logLevel) noexcept
    void TraceLog(int logLevel, const char *text, ...) noexcept
    void SetTraceLogCallback(TraceLogCallback callback) noexcept

    # === Memory management, using internal allocators ===
    void *MemAlloc(unsigned int size) noexcept
    void *MemRealloc(void *ptr, unsigned int size) noexcept
    void MemFree(void *ptr) noexcept

    # === File system management functions ===
    unsigned char *LoadFileData(const char *fileName, int *dataSize) noexcept
    void UnloadFileData(unsigned char *data) noexcept
    bint SaveFileData(const char *fileName, void *data, int dataSize) noexcept
    bint ExportDataAsCode(const unsigned char *data, int dataSize, const char *fileName) noexcept
    char *LoadFileText(const char *fileName) noexcept
    void UnloadFileText(char *text) noexcept
    bint SaveFileText(const char *fileName, const char *text) noexcept

    # === File access custom callbacks ===
    void SetLoadFileDataCallback(LoadFileDataCallback callback) noexcept
    void SetSaveFileDataCallback(SaveFileDataCallback callback) noexcept
    void SetLoadFileTextCallback(LoadFileTextCallback callback) noexcept
    void SetSaveFileTextCallback(SaveFileTextCallback callback) noexcept

    int FileRename(const char *fileName, const char *fileRename) noexcept
    int FileRemove(const char *fileName) noexcept
    int FileCopy(const char *srcPath, const char *dstPath) noexcept
    int FileMove(const char *srcPath, const char *dstPath) noexcept
    int FileTextReplace(const char *fileName, const char *search, const char *replacement) noexcept
    int FileTextFindIndex(const char *fileName, const char *search) noexcept
    bint FileExists(const char *fileName) noexcept
    bint DirectoryExists(const char *dirPath) noexcept
    bint IsFileExtension(const char *fileName, const char *ext) noexcept
    int GetFileLength(const char *fileName) noexcept
    long GetFileModTime(const char *fileName) noexcept
    const char *GetFileExtension(const char *fileName) noexcept
    const char *GetFileName(const char *filePath) noexcept
    const char *GetFileNameWithoutExt(const char *filePath) noexcept
    const char *GetDirectoryPath(const char *filePath) noexcept
    const char *GetPrevDirectoryPath(const char *dirPath) noexcept
    const char *GetWorkingDirectory() noexcept
    const char *GetApplicationDirectory() noexcept
    int MakeDirectory(const char *dirPath) noexcept
    bint ChangeDirectory(const char *dirPath) noexcept
    bint IsPathFile(const char *path) noexcept
    bint IsFileNameValid(const char *fileName) noexcept
    FilePathList LoadDirectoryFiles(const char *dirPath) noexcept
    FilePathList LoadDirectoryFilesEx(const char *basePath, const char *filter, bint scanSubdirs) noexcept
    void UnloadDirectoryFiles(FilePathList files) noexcept
    bint IsFileDropped() noexcept
    FilePathList LoadDroppedFiles() noexcept
    void UnloadDroppedFiles(FilePathList files) noexcept
    unsigned int GetDirectoryFileCount(const char *dirPath) noexcept
    unsigned int GetDirectoryFileCountEx(const char *basePath, const char *filter, bint scanSubdirs) noexcept

    # === Compression/Encoding functionality ===
    unsigned char *CompressData(const unsigned char *data, int dataSize, int *compDataSize) noexcept
    unsigned char *DecompressData(const unsigned char *compData, int compDataSize, int *dataSize) noexcept
    char *EncodeDataBase64(const unsigned char *data, int dataSize, int *outputSize) noexcept
    unsigned char *DecodeDataBase64(const char *text, int *outputSize) noexcept
    unsigned int ComputeCRC32(unsigned char *data, int dataSize) noexcept
    unsigned int *ComputeMD5(unsigned char *data, int dataSize) noexcept
    unsigned int *ComputeSHA1(unsigned char *data, int dataSize) noexcept
    unsigned int *ComputeSHA256(unsigned char *data, int dataSize) noexcept

    # === Automation events functionality ===
    AutomationEventList LoadAutomationEventList(const char *fileName) noexcept
    void UnloadAutomationEventList(AutomationEventList list) noexcept
    bint ExportAutomationEventList(AutomationEventList list, const char *fileName) noexcept
    void SetAutomationEventList(AutomationEventList *list) noexcept
    void SetAutomationEventBaseFrame(int frame) noexcept
    void StartAutomationEventRecording() noexcept
    void StopAutomationEventRecording() noexcept
    void PlayAutomationEvent(AutomationEvent event) noexcept

    # === Input-related functions: keyboard ===
    bint IsKeyPressed(int key) noexcept
    bint IsKeyPressedRepeat(int key) noexcept
    bint IsKeyDown(int key) noexcept
    bint IsKeyReleased(int key) noexcept
    bint IsKeyUp(int key) noexcept
    int GetKeyPressed() noexcept
    int GetCharPressed() noexcept
    const char *GetKeyName(int key) noexcept
    void SetExitKey(int key) noexcept

    # === Input-related functions: gamepads ===
    bint IsGamepadAvailable(int gamepad) noexcept
    const char *GetGamepadName(int gamepad) noexcept
    bint IsGamepadButtonPressed(int gamepad, int button) noexcept
    bint IsGamepadButtonDown(int gamepad, int button) noexcept
    bint IsGamepadButtonReleased(int gamepad, int button) noexcept
    bint IsGamepadButtonUp(int gamepad, int button) noexcept
    int GetGamepadButtonPressed() noexcept
    int GetGamepadAxisCount(int gamepad) noexcept
    float GetGamepadAxisMovement(int gamepad, int axis) noexcept
    int SetGamepadMappings(const char *mappings) noexcept
    void SetGamepadVibration(int gamepad, float leftMotor, float rightMotor, float duration) noexcept

    # === Input-related functions: mouse ===
    bint IsMouseButtonPressed(int button) noexcept
    bint IsMouseButtonDown(int button) noexcept
    bint IsMouseButtonReleased(int button) noexcept
    bint IsMouseButtonUp(int button) noexcept
    int GetMouseX() noexcept
    int GetMouseY() noexcept
    Vector2 GetMousePosition() noexcept
    Vector2 GetMouseDelta() noexcept
    void SetMousePosition(int x, int y) noexcept
    void SetMouseOffset(int offsetX, int offsetY) noexcept
    void SetMouseScale(float scaleX, float scaleY) noexcept
    float GetMouseWheelMove() noexcept
    Vector2 GetMouseWheelMoveV() noexcept
    void SetMouseCursor(int cursor) noexcept

    # === Input-related functions: touch ===
    int GetTouchX() noexcept
    int GetTouchY() noexcept
    Vector2 GetTouchPosition(int index) noexcept
    int GetTouchPointId(int index) noexcept
    int GetTouchPointCount() noexcept

    # === Gestures and Touch Handling Functions ===
    void SetGesturesEnabled(unsigned int flags) noexcept
    bint IsGestureDetected(unsigned int gesture) noexcept
    int GetGestureDetected() noexcept
    float GetGestureHoldDuration() noexcept
    Vector2 GetGestureDragVector() noexcept
    float GetGestureDragAngle() noexcept
    Vector2 GetGesturePinchVector() noexcept
    float GetGesturePinchAngle() noexcept

    # === Camera System Functions ===
    void UpdateCamera(Camera *camera, int mode) noexcept
    void UpdateCameraPro(Camera *camera, Vector3 movement, Vector3 rotation, float zoom) noexcept

    # === Basic Shapes Drawing Functions (Module: shapes) ===
    void SetShapesTexture(Texture texture, Rectangle source) noexcept
    Texture GetShapesTexture() noexcept
    Rectangle GetShapesTextureRectangle() noexcept

    # === Basic shapes drawing functions ===
    void DrawPixel(int posX, int posY, Color color) noexcept
    void DrawPixelV(Vector2 position, Color color) noexcept
    void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color) noexcept
    void DrawLineV(Vector2 startPos, Vector2 endPos, Color color) noexcept
    void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color) noexcept
    void DrawLineStrip(const Vector2 *points, int pointCount, Color color) noexcept
    void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color) noexcept
    void DrawLineDashed(Vector2 startPos, Vector2 endPos, int dashSize, int spaceSize, Color color) noexcept
    void DrawCircle(int centerX, int centerY, float radius, Color color) noexcept
    void DrawCircleV(Vector2 center, float radius, Color color) noexcept
    void DrawCircleGradient(Vector2 center, float radius, Color inner, Color outer) noexcept
    void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color) noexcept
    void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color) noexcept
    void DrawCircleLines(int centerX, int centerY, float radius, Color color) noexcept
    void DrawCircleLinesV(Vector2 center, float radius, Color color) noexcept
    void DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color) noexcept
    void DrawEllipseV(Vector2 center, float radiusH, float radiusV, Color color) noexcept
    void DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color) noexcept
    void DrawEllipseLinesV(Vector2 center, float radiusH, float radiusV, Color color) noexcept
    void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color) noexcept
    void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color) noexcept
    void DrawRectangle(int posX, int posY, int width, int height, Color color) noexcept
    void DrawRectangleV(Vector2 position, Vector2 size, Color color) noexcept
    void DrawRectangleRec(Rectangle rec, Color color) noexcept
    void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color) noexcept
    void DrawRectangleGradientV(int posX, int posY, int width, int height, Color top, Color bottom) noexcept
    void DrawRectangleGradientH(int posX, int posY, int width, int height, Color left, Color right) noexcept
    void DrawRectangleGradientEx(Rectangle rec, Color topLeft, Color bottomLeft, Color bottomRight, Color topRight) noexcept
    void DrawRectangleLines(int posX, int posY, int width, int height, Color color) noexcept
    void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color) noexcept
    void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color) noexcept
    void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, Color color) noexcept
    void DrawRectangleRoundedLinesEx(Rectangle rec, float roundness, int segments, float lineThick, Color color) noexcept
    void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color) noexcept
    void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color) noexcept
    void DrawTriangleFan(const Vector2 *points, int pointCount, Color color) noexcept
    void DrawTriangleStrip(const Vector2 *points, int pointCount, Color color) noexcept
    void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color) noexcept
    void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color) noexcept
    void DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color) noexcept

    # === Splines drawing functions ===
    void DrawSplineLinear(const Vector2 *points, int pointCount, float thick, Color color) noexcept
    void DrawSplineBasis(const Vector2 *points, int pointCount, float thick, Color color) noexcept
    void DrawSplineCatmullRom(const Vector2 *points, int pointCount, float thick, Color color) noexcept
    void DrawSplineBezierQuadratic(const Vector2 *points, int pointCount, float thick, Color color) noexcept
    void DrawSplineBezierCubic(const Vector2 *points, int pointCount, float thick, Color color) noexcept
    void DrawSplineSegmentLinear(Vector2 p1, Vector2 p2, float thick, Color color) noexcept
    void DrawSplineSegmentBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color) noexcept
    void DrawSplineSegmentCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color) noexcept
    void DrawSplineSegmentBezierQuadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color) noexcept
    void DrawSplineSegmentBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color) noexcept

    # === Spline segment point evaluation functions, for a given t [0.0f .. 1.0f] ===
    Vector2 GetSplinePointLinear(Vector2 startPos, Vector2 endPos, float t) noexcept
    Vector2 GetSplinePointBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t) noexcept
    Vector2 GetSplinePointCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t) noexcept
    Vector2 GetSplinePointBezierQuad(Vector2 p1, Vector2 c2, Vector2 p3, float t) noexcept
    Vector2 GetSplinePointBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t) noexcept

    # === Basic shapes collision detection functions ===
    bint CheckCollisionRecs(Rectangle rec1, Rectangle rec2) noexcept
    bint CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2) noexcept
    bint CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec) noexcept
    bint CheckCollisionCircleLine(Vector2 center, float radius, Vector2 p1, Vector2 p2) noexcept
    bint CheckCollisionPointRec(Vector2 point, Rectangle rec) noexcept
    bint CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius) noexcept
    bint CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3) noexcept
    bint CheckCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int threshold) noexcept
    bint CheckCollisionPointPoly(Vector2 point, const Vector2 *points, int pointCount) noexcept
    bint CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint) noexcept
    Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2) noexcept

    # === Texture Loading and Drawing Functions (Module: textures) ===

    # === Image loading functions ===
    # === NOTE: These functions do not require GPU access ===
    Image LoadImage(const char *fileName) noexcept
    Image LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize) noexcept
    Image LoadImageAnim(const char *fileName, int *frames) noexcept
    Image LoadImageAnimFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int *frames) noexcept
    Image LoadImageFromMemory(const char *fileType, const unsigned char *fileData, int dataSize) noexcept
    Image LoadImageFromTexture(Texture texture) noexcept
    Image LoadImageFromScreen() noexcept
    bint IsImageValid(Image image) noexcept
    void UnloadImage(Image image) noexcept
    bint ExportImage(Image image, const char *fileName) noexcept
    unsigned char *ExportImageToMemory(Image image, const char *fileType, int *fileSize) noexcept
    bint ExportImageAsCode(Image image, const char *fileName) noexcept

    # === Image generation functions ===
    Image GenImageColor(int width, int height, Color color) noexcept
    Image GenImageGradientLinear(int width, int height, int direction, Color start, Color end) noexcept
    Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer) noexcept
    Image GenImageGradientSquare(int width, int height, float density, Color inner, Color outer) noexcept
    Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2) noexcept
    Image GenImageWhiteNoise(int width, int height, float factor) noexcept
    Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale) noexcept
    Image GenImageCellular(int width, int height, int tileSize) noexcept
    Image GenImageText(int width, int height, const char *text) noexcept

    # === Image manipulation functions ===
    Image ImageCopy(Image image) noexcept
    Image ImageFromImage(Image image, Rectangle rec) noexcept
    Image ImageFromChannel(Image image, int selectedChannel) noexcept
    Image ImageText(const char *text, int fontSize, Color color) noexcept
    Image ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint) noexcept
    void ImageFormat(Image *image, int newFormat) noexcept
    void ImageToPOT(Image *image, Color fill) noexcept
    void ImageCrop(Image *image, Rectangle crop) noexcept
    void ImageAlphaCrop(Image *image, float threshold) noexcept
    void ImageAlphaClear(Image *image, Color color, float threshold) noexcept
    void ImageAlphaMask(Image *image, Image alphaMask) noexcept
    void ImageAlphaPremultiply(Image *image) noexcept
    void ImageBlurGaussian(Image *image, int blurSize) noexcept
    void ImageKernelConvolution(Image *image, const float *kernel, int kernelSize) noexcept
    void ImageResize(Image *image, int newWidth, int newHeight) noexcept
    void ImageResizeNN(Image *image, int newWidth, int newHeight) noexcept
    void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill) noexcept
    void ImageMipmaps(Image *image) noexcept
    void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp) noexcept
    void ImageFlipVertical(Image *image) noexcept
    void ImageFlipHorizontal(Image *image) noexcept
    void ImageRotate(Image *image, int degrees) noexcept
    void ImageRotateCW(Image *image) noexcept
    void ImageRotateCCW(Image *image) noexcept
    void ImageColorTint(Image *image, Color color) noexcept
    void ImageColorInvert(Image *image) noexcept
    void ImageColorGrayscale(Image *image) noexcept
    void ImageColorContrast(Image *image, float contrast) noexcept
    void ImageColorBrightness(Image *image, int brightness) noexcept
    void ImageColorReplace(Image *image, Color color, Color replace) noexcept
    Color *LoadImageColors(Image image) noexcept
    Color *LoadImagePalette(Image image, int maxPaletteSize, int *colorCount) noexcept
    void UnloadImageColors(Color *colors) noexcept
    void UnloadImagePalette(Color *colors) noexcept
    Rectangle GetImageAlphaBorder(Image image, float threshold) noexcept
    Color GetImageColor(Image image, int x, int y) noexcept

    # === Image drawing functions ===
    void ImageClearBackground(Image *dst, Color color) noexcept
    void ImageDrawPixel(Image *dst, int posX, int posY, Color color) noexcept
    void ImageDrawPixelV(Image *dst, Vector2 position, Color color) noexcept
    void ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color) noexcept
    void ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color) noexcept
    void ImageDrawLineEx(Image *dst, Vector2 start, Vector2 end, int thick, Color color) noexcept
    void ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color) noexcept
    void ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color) noexcept
    void ImageDrawCircleLines(Image *dst, int centerX, int centerY, int radius, Color color) noexcept
    void ImageDrawCircleLinesV(Image *dst, Vector2 center, int radius, Color color) noexcept
    void ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color) noexcept
    void ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color) noexcept
    void ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color) noexcept
    void ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color) noexcept
    void ImageDrawTriangle(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color) noexcept
    void ImageDrawTriangleEx(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color c1, Color c2, Color c3) noexcept
    void ImageDrawTriangleLines(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color) noexcept
    void ImageDrawTriangleFan(Image *dst, const Vector2 *points, int pointCount, Color color) noexcept
    void ImageDrawTriangleStrip(Image *dst, const Vector2 *points, int pointCount, Color color) noexcept
    void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint) noexcept
    void ImageDrawText(Image *dst, const char *text, int posX, int posY, int fontSize, Color color) noexcept
    void ImageDrawTextEx(Image *dst, Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint) noexcept

    # === Texture loading functions ===
    Texture LoadTexture(const char *fileName) noexcept
    Texture LoadTextureFromImage(Image image) noexcept
    TextureCubemap LoadTextureCubemap(Image image, int layout) noexcept
    RenderTexture2D LoadRenderTexture(int width, int height) noexcept
    bint IsTextureValid(Texture texture) noexcept
    void UnloadTexture(Texture texture) noexcept
    bint IsRenderTextureValid(RenderTexture2D target) noexcept
    void UnloadRenderTexture(RenderTexture2D target) noexcept
    void UpdateTexture(Texture texture, const void *pixels) noexcept
    void UpdateTextureRec(Texture texture, Rectangle rec, const void *pixels) noexcept

    # === Texture configuration functions ===
    void GenTextureMipmaps(Texture *texture) noexcept
    void SetTextureFilter(Texture texture, int filter) noexcept
    void SetTextureWrap(Texture texture, int wrap) noexcept

    # === Texture drawing functions ===
    void DrawTexture(Texture texture, int posX, int posY, Color tint) noexcept
    void DrawTextureV(Texture texture, Vector2 position, Color tint) noexcept
    void DrawTextureEx(Texture texture, Vector2 position, float rotation, float scale, Color tint) noexcept
    void DrawTextureRec(Texture texture, Rectangle source, Vector2 position, Color tint) noexcept
    void DrawTexturePro(Texture texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint) noexcept
    void DrawTextureNPatch(Texture texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint) noexcept

    # === Color/pixel related functions ===
    bint ColorIsEqual(Color col1, Color col2) noexcept
    Color Fade(Color color, float alpha) noexcept
    int ColorToInt(Color color) noexcept
    Vector4 ColorNormalize(Color color) noexcept
    Color ColorFromNormalized(Vector4 normalized) noexcept
    Vector3 ColorToHSV(Color color) noexcept
    Color ColorFromHSV(float hue, float saturation, float value) noexcept
    Color ColorTint(Color color, Color tint) noexcept
    Color ColorBrightness(Color color, float factor) noexcept
    Color ColorContrast(Color color, float contrast) noexcept
    Color ColorAlpha(Color color, float alpha) noexcept
    Color ColorAlphaBlend(Color dst, Color src, Color tint) noexcept
    Color ColorLerp(Color color1, Color color2, float factor) noexcept
    Color GetColor(unsigned int hexValue) noexcept
    Color GetPixelColor(void *srcPtr, int format) noexcept
    void SetPixelColor(void *dstPtr, Color color, int format) noexcept
    int GetPixelDataSize(int width, int height, int format) noexcept

    # === Font loading/unloading functions ===
    Font GetFontDefault() noexcept
    Font LoadFont(const char *fileName) noexcept
    Font LoadFontEx(const char *fileName, int fontSize, const int *codepoints, int codepointCount) noexcept
    Font LoadFontFromImage(Image image, Color key, int firstChar) noexcept
    Font LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, const int *codepoints, int codepointCount) noexcept
    bint IsFontValid(Font font) noexcept
    GlyphInfo *LoadFontData(const unsigned char *fileData, int dataSize, int fontSize, const int *codepoints, int codepointCount, int type, int *glyphCount) noexcept
    Image GenImageFontAtlas(const GlyphInfo *glyphs, Rectangle **glyphRecs, int glyphCount, int fontSize, int padding, int packMethod) noexcept
    void UnloadFontData(GlyphInfo *glyphs, int glyphCount) noexcept
    void UnloadFont(Font font) noexcept
    bint ExportFontAsCode(Font font, const char *fileName) noexcept

    # === Text drawing functions ===
    void DrawFPS(int posX, int posY) noexcept
    void DrawText(const char *text, int posX, int posY, int fontSize, Color color) noexcept
    void DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint) noexcept
    void DrawTextPro(Font font, const char *text, Vector2 position, Vector2 origin, float rotation, float fontSize, float spacing, Color tint) noexcept
    void DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint) noexcept
    void DrawTextCodepoints(Font font, const int *codepoints, int codepointCount, Vector2 position, float fontSize, float spacing, Color tint) noexcept

    # === Text font info functions ===
    void SetTextLineSpacing(int spacing) noexcept
    int MeasureText(const char *text, int fontSize) noexcept
    Vector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing) noexcept
    Vector2 MeasureTextCodepoints(Font font, const int *codepoints, int length, float fontSize, float spacing) noexcept
    int GetGlyphIndex(Font font, int codepoint) noexcept
    GlyphInfo GetGlyphInfo(Font font, int codepoint) noexcept
    Rectangle GetGlyphAtlasRec(Font font, int codepoint) noexcept

    # === Text codepoints management functions (unicode characters) ===
    char *LoadUTF8(const int *codepoints, int length) noexcept
    void UnloadUTF8(char *text) noexcept
    int *LoadCodepoints(const char *text, int *count) noexcept
    void UnloadCodepoints(int *codepoints) noexcept
    int GetCodepointCount(const char *text) noexcept
    int GetCodepoint(const char *text, int *codepointSize) noexcept
    int GetCodepointNext(const char *text, int *codepointSize) noexcept
    int GetCodepointPrevious(const char *text, int *codepointSize) noexcept
    const char *CodepointToUTF8(int codepoint, int *utf8Size) noexcept

    # === Text strings management functions (no UTF-8 strings, only byte chars) ===
    char **LoadTextLines(const char *text, int *count) noexcept
    void UnloadTextLines(char **text, int lineCount) noexcept
    int TextCopy(char *dst, const char *src) noexcept
    bint TextIsEqual(const char *text1, const char *text2) noexcept
    unsigned int TextLength(const char *text) noexcept
    const char *TextFormat(const char *text, ...) noexcept
    const char *TextSubtext(const char *text, int position, int length) noexcept
    const char *TextRemoveSpaces(const char *text) noexcept
    char *GetTextBetween(const char *text, const char *begin, const char *end) noexcept
    char *TextReplace(const char *text, const char *search, const char *replacement) noexcept
    char *TextReplaceAlloc(const char *text, const char *search, const char *replacement) noexcept
    char *TextReplaceBetween(const char *text, const char *begin, const char *end, const char *replacement) noexcept
    char *TextReplaceBetweenAlloc(const char *text, const char *begin, const char *end, const char *replacement) noexcept
    char *TextInsert(const char *text, const char *insert, int position) noexcept
    char *TextInsertAlloc(const char *text, const char *insert, int position) noexcept
    char *TextJoin(char **textList, int count, const char *delimiter) noexcept
    char **TextSplit(const char *text, char delimiter, int *count) noexcept
    void TextAppend(char *text, const char *append, int *position) noexcept
    int TextFindIndex(const char *text, const char *search) noexcept
    char *TextToUpper(const char *text) noexcept
    char *TextToLower(const char *text) noexcept
    char *TextToPascal(const char *text) noexcept
    char *TextToSnake(const char *text) noexcept
    char *TextToCamel(const char *text) noexcept
    int TextToInteger(const char *text) noexcept
    float TextToFloat(const char *text) noexcept

    # === Basic geometric 3D shapes drawing functions ===
    void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color) noexcept
    void DrawPoint3D(Vector3 position, Color color) noexcept
    void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color) noexcept
    void DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color) noexcept
    void DrawTriangleStrip3D(const Vector3 *points, int pointCount, Color color) noexcept
    void DrawCube(Vector3 position, float width, float height, float length, Color color) noexcept
    void DrawCubeV(Vector3 position, Vector3 size, Color color) noexcept
    void DrawCubeWires(Vector3 position, float width, float height, float length, Color color) noexcept
    void DrawCubeWiresV(Vector3 position, Vector3 size, Color color) noexcept
    void DrawSphere(Vector3 centerPos, float radius, Color color) noexcept
    void DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color) noexcept
    void DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color) noexcept
    void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color) noexcept
    void DrawCylinderEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color) noexcept
    void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color) noexcept
    void DrawCylinderWiresEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color) noexcept
    void DrawCapsule(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color) noexcept
    void DrawCapsuleWires(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color) noexcept
    void DrawPlane(Vector3 centerPos, Vector2 size, Color color) noexcept
    void DrawRay(Ray ray, Color color) noexcept
    void DrawGrid(int slices, float spacing) noexcept

    # === Model management functions ===
    Model LoadModel(const char *fileName) noexcept
    Model LoadModelFromMesh(Mesh mesh) noexcept
    bint IsModelValid(Model model) noexcept
    void UnloadModel(Model model) noexcept
    BoundingBox GetModelBoundingBox(Model model) noexcept

    # === Model drawing functions ===
    void DrawModel(Model model, Vector3 position, float scale, Color tint) noexcept
    void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint) noexcept
    void DrawModelWires(Model model, Vector3 position, float scale, Color tint) noexcept
    void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint) noexcept
    void DrawBoundingBox(BoundingBox box, Color color) noexcept
    void DrawBillboard(Camera camera, Texture texture, Vector3 position, float scale, Color tint) noexcept
    void DrawBillboardRec(Camera camera, Texture texture, Rectangle source, Vector3 position, Vector2 size, Color tint) noexcept
    void DrawBillboardPro(Camera camera, Texture texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint) noexcept

    # === Mesh management functions ===
    void UploadMesh(Mesh *mesh, bint dynamic) noexcept
    void UpdateMeshBuffer(Mesh mesh, int index, const void *data, int dataSize, int offset) noexcept
    void UnloadMesh(Mesh mesh) noexcept
    void DrawMesh(Mesh mesh, Material material, Matrix transform) noexcept
    void DrawMeshInstanced(Mesh mesh, Material material, const Matrix *transforms, int instances) noexcept
    BoundingBox GetMeshBoundingBox(Mesh mesh) noexcept
    void GenMeshTangents(Mesh *mesh) noexcept
    bint ExportMesh(Mesh mesh, const char *fileName) noexcept
    bint ExportMeshAsCode(Mesh mesh, const char *fileName) noexcept

    # === Mesh generation functions ===
    Mesh GenMeshPoly(int sides, float radius) noexcept
    Mesh GenMeshPlane(float width, float length, int resX, int resZ) noexcept
    Mesh GenMeshCube(float width, float height, float length) noexcept
    Mesh GenMeshSphere(float radius, int rings, int slices) noexcept
    Mesh GenMeshHemiSphere(float radius, int rings, int slices) noexcept
    Mesh GenMeshCylinder(float radius, float height, int slices) noexcept
    Mesh GenMeshCone(float radius, float height, int slices) noexcept
    Mesh GenMeshTorus(float radius, float size, int radSeg, int sides) noexcept
    Mesh GenMeshKnot(float radius, float size, int radSeg, int sides) noexcept
    Mesh GenMeshHeightmap(Image heightmap, Vector3 size) noexcept
    Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize) noexcept

    # === Material loading/unloading functions ===
    Material *LoadMaterials(const char *fileName, int *materialCount) noexcept
    Material LoadMaterialDefault() noexcept
    bint IsMaterialValid(Material material) noexcept
    void UnloadMaterial(Material material) noexcept
    void SetMaterialTexture(Material *material, int mapType, Texture texture) noexcept
    void SetModelMeshMaterial(Model *model, int meshId, int materialId) noexcept

    # === Model animations loading/unloading functions ===
    ModelAnimation *LoadModelAnimations(const char *fileName, int *animCount) noexcept
    void UpdateModelAnimation(Model model, ModelAnimation anim, float frame) noexcept
    void UpdateModelAnimationEx(Model model, ModelAnimation animA, float frameA, ModelAnimation animB, float frameB, float blend) noexcept
    void UnloadModelAnimations(ModelAnimation *animations, int animCount) noexcept
    bint IsModelAnimationValid(Model model, ModelAnimation anim) noexcept

    # === Collision detection functions ===
    bint CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2) noexcept
    bint CheckCollisionBoxes(BoundingBox box1, BoundingBox box2) noexcept
    bint CheckCollisionBoxSphere(BoundingBox box, Vector3 center, float radius) noexcept
    RayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius) noexcept
    RayCollision GetRayCollisionBox(Ray ray, BoundingBox box) noexcept
    RayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform) noexcept
    RayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3) noexcept
    RayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) noexcept

    ctypedef void (*AudioCallback)(void *bufferData, unsigned int frames)

    # === Audio device management functions ===
    void InitAudioDevice() noexcept
    void CloseAudioDevice() noexcept
    bint IsAudioDeviceReady() noexcept
    void SetMasterVolume(float volume) noexcept
    float GetMasterVolume() noexcept

    # === Wave/Sound loading/unloading functions ===
    Wave LoadWave(const char *fileName) noexcept
    Wave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize) noexcept
    bint IsWaveValid(Wave wave) noexcept
    Sound LoadSound(const char *fileName) noexcept
    Sound LoadSoundFromWave(Wave wave) noexcept
    Sound LoadSoundAlias(Sound source) noexcept
    bint IsSoundValid(Sound sound) noexcept
    void UpdateSound(Sound sound, const void *data, int sampleCount) noexcept
    void UnloadWave(Wave wave) noexcept
    void UnloadSound(Sound sound) noexcept
    void UnloadSoundAlias(Sound alias) noexcept
    bint ExportWave(Wave wave, const char *fileName) noexcept
    bint ExportWaveAsCode(Wave wave, const char *fileName) noexcept

    # === Wave/Sound management functions ===
    void PlaySound(Sound sound) noexcept
    void StopSound(Sound sound) noexcept
    void PauseSound(Sound sound) noexcept
    void ResumeSound(Sound sound) noexcept
    bint IsSoundPlaying(Sound sound) noexcept
    void SetSoundVolume(Sound sound, float volume) noexcept
    void SetSoundPitch(Sound sound, float pitch) noexcept
    void SetSoundPan(Sound sound, float pan) noexcept
    Wave WaveCopy(Wave wave) noexcept
    void WaveCrop(Wave *wave, int initFrame, int finalFrame) noexcept
    void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels) noexcept
    float *LoadWaveSamples(Wave wave) noexcept
    void UnloadWaveSamples(float *samples) noexcept

    # === Music management functions ===
    Music LoadMusicStream(const char *fileName) noexcept
    Music LoadMusicStreamFromMemory(const char *fileType, const unsigned char *data, int dataSize) noexcept
    bint IsMusicValid(Music music) noexcept
    void UnloadMusicStream(Music music) noexcept
    void PlayMusicStream(Music music) noexcept
    bint IsMusicStreamPlaying(Music music) noexcept
    void UpdateMusicStream(Music music) noexcept
    void StopMusicStream(Music music) noexcept
    void PauseMusicStream(Music music) noexcept
    void ResumeMusicStream(Music music) noexcept
    void SeekMusicStream(Music music, float position) noexcept
    void SetMusicVolume(Music music, float volume) noexcept
    void SetMusicPitch(Music music, float pitch) noexcept
    void SetMusicPan(Music music, float pan) noexcept
    float GetMusicTimeLength(Music music) noexcept
    float GetMusicTimePlayed(Music music) noexcept

    # === AudioStream management functions ===
    AudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels) noexcept
    bint IsAudioStreamValid(AudioStream stream) noexcept
    void UnloadAudioStream(AudioStream stream) noexcept
    void UpdateAudioStream(AudioStream stream, const void *data, int frameCount) noexcept
    bint IsAudioStreamProcessed(AudioStream stream) noexcept
    void PlayAudioStream(AudioStream stream) noexcept
    void PauseAudioStream(AudioStream stream) noexcept
    void ResumeAudioStream(AudioStream stream) noexcept
    bint IsAudioStreamPlaying(AudioStream stream) noexcept
    void StopAudioStream(AudioStream stream) noexcept
    void SetAudioStreamVolume(AudioStream stream, float volume) noexcept
    void SetAudioStreamPitch(AudioStream stream, float pitch) noexcept
    void SetAudioStreamPan(AudioStream stream, float pan) noexcept
    void SetAudioStreamBufferSizeDefault(int size) noexcept
    void SetAudioStreamCallback(AudioStream stream, AudioCallback callback) noexcept

    void AttachAudioStreamProcessor(AudioStream stream, AudioCallback processor) noexcept
    void DetachAudioStreamProcessor(AudioStream stream, AudioCallback processor) noexcept

    void AttachAudioMixedProcessor(AudioCallback processor) noexcept
    void DetachAudioMixedProcessor(AudioCallback processor) noexcept
