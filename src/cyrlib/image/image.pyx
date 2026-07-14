from cyrlib.raylib.raylib cimport (
    Image as image_t,
    LoadImage,
    LoadImageRaw,
    LoadImageAnim,
    UnloadImage,
    LoadImageFromScreen,
    IsImageValid,
    ExportImage,
    ImageCopy,
    GenImageColor,
    GenImageGradientLinear,
    GenImageGradientRadial,
    GenImageGradientSquare,
    GenImageChecked,
    GenImageWhiteNoise,
    GenImagePerlinNoise,
    GenImageCellular,
    GenImageText,
    ImageFromChannel,
    GetPixelDataSize
)

from cyrlib.color.color cimport Color

cdef class Image:

    @staticmethod
    cdef inline Image new(image_t rl_image):
        cdef Image image = Image.__new__(Image)
        image._raw = rl_image
        return image

    def __dealloc__(self):
        if self.valid:
            UnloadImage(self._raw)

    def __copy__(self):
        return self.copy()

    def __deepcopy__(self, memo):
        return self.copy()

    def __repr__(self):
        if not self.valid:
            return "<Image Invalid/Unloaded>"
        return f"<Image {self.width}x{self.height} format={self.format}>"

    @staticmethod
    cdef inline Image c_load(str file_name):
        cdef bytes file_name_bytes = file_name.encode("utf-8")
        cdef image_t rl_image = LoadImage(file_name_bytes)
        return Image.new(rl_image)

    @staticmethod
    cdef inline Image c_load_raw(str file_name, int width, int height, int format, int header_size):
        cdef bytes file_name_bytes = file_name.encode("utf-8")
        cdef image_t rl_image = LoadImageRaw(file_name_bytes, width, height, format, header_size)
        return Image.new(rl_image)

    @staticmethod
    cdef inline Image c_load_anim(str file_name, int * frames):
        cdef bytes file_name_bytes = file_name.encode("utf-8")
        cdef image_t rl_image = LoadImageAnim(file_name_bytes, frames)
        return Image.new(rl_image)

    @staticmethod
    cdef inline Image c_load_from_screen():
        cdef image_t rl_image = LoadImageFromScreen()
        return Image.new(rl_image)

    cdef inline Image c_copy(self):
        cdef image_t copied_image = ImageCopy(self._raw)
        return Image.new(copied_image)

    cpdef bint export(self, str file_name):
        cdef bytes file_name_bytes = file_name.encode("utf-8")
        return ExportImage(self._raw, file_name_bytes)

    cpdef void unload(self):
        UnloadImage(self._raw)
        self._raw.data = NULL

    cpdef Image copy(self):
        return self.c_copy()

    @staticmethod
    def load(str file_name) -> Image:
        return Image.c_load(file_name)

    @staticmethod
    def load_raw(str file_name, int width, int height, int format, int header) -> Image:
        return Image.c_load_raw(file_name, width, height, format, header)

    @staticmethod
    def load_anim(str file_name) -> tuple[Image, int]:
        cdef int frames = 0
        cdef Image img = Image.c_load_anim(file_name, &frames)
        return img, frames

    @staticmethod
    def load_from_screen() -> Image:
        return Image.c_load_from_screen()

    @staticmethod
    def generate_with_color(int width, int height, Color color) -> Image:
        cdef image_t rl_image = GenImageColor(width, height, color._raw)
        return Image.new(rl_image)

    @staticmethod
    def generate_with_linear_gradient(int width, int height, int direction, Color start, Color end) -> Image:
        cdef image_t rl_image = GenImageGradientLinear(width, height, direction, start._raw, end._raw)
        return Image.new(rl_image)

    @staticmethod
    def generate_with_radial_gradient(int width, int height, double density, Color inner, Color outer) -> Image:
        cdef image_t rl_image = GenImageGradientRadial(width, height, density, inner._raw, outer._raw)
        return Image.new(rl_image)

    @staticmethod
    def generate_with_square_gradient(int width, int height, double density, Color inner, Color outer) -> Image:
        cdef image_t rl_image = GenImageGradientSquare(width, height, density, inner._raw, outer._raw)
        return Image.new(rl_image)

    @staticmethod
    def generate_with_checked(int width, int height, int check_x, int check_y, Color col1, Color col2) -> Image:
        cdef image_t rl_image = GenImageChecked(width, height, check_x, check_y, col1._raw, col2._raw)
        return Image.new(rl_image)

    @staticmethod
    def generate_with_white_noise(int width, int height, double factor) -> Image:
        cdef image_t rl_image = GenImageWhiteNoise(width, height, factor)
        return Image.new(rl_image)

    @staticmethod
    def generate_with_perlin_noise(int width, int height, int offset_x, int offset_y, double scale) -> Image:
        cdef image_t rl_image = GenImagePerlinNoise(width, height, offset_x, offset_y, scale)
        return Image.new(rl_image)

    @staticmethod
    def generate_with_cellular(int width, int height, int tile_size) -> Image:
        cdef image_t rl_image = GenImageCellular(width, height, tile_size)
        return Image.new(rl_image)

    @staticmethod
    def generate_with_text(int width, int height, str text) -> Image:
        cdef bytes text_bytes = text.encode("utf-8")
        cdef image_t rl_image = GenImageText(width, height, text_bytes)
        return Image.new(rl_image)

    cpdef Image from_channel(self, int selected_channel):
        return Image.new(ImageFromChannel(self._raw, selected_channel))

    @property
    def valid(self) -> bool:
        return IsImageValid(self._raw)

    @property
    def width(self) -> int:
        return self._raw.width

    @property
    def height(self) -> int:
        return self._raw.height

    @property
    def mipmaps(self) -> int:
        return self._raw.mipmaps

    @property
    def format(self) -> int:
        return self._raw.format

    @property
    def data_view(self):
        if not self.valid:
            raise ValueError("Image data is empty or Image has been unloaded.")
        cdef int size = GetPixelDataSize(self._raw.width, self._raw.height, self._raw.format)
        cdef unsigned char[:] view = <unsigned char[:size]>self._raw.data
        return view
