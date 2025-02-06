package pdfio

import "core:c"

_ :: c

foreign import lib "pdfio1.lib"

cs_t :: enum c.int {
	ADOBE,
	P3_D65,
	SRGB,
}

linecap_t :: enum c.int {
	BUTT,
	ROUND,
	SQUARE,
}

linejoin_t :: enum c.int {
	MITER,
	ROUND,
	BEVEL,
}

textrendering_t :: enum c.int {
	FILL,
	STROKE,
	FILL_AND_STROKE,
	INVISIBLE,
	FILL_PATH,
	STROKE_PATH,
	FILL_AND_STROKE_PATH,
	TEXT_PATH,
}

matrix_t :: distinct [3][2]f64

@(default_calling_convention="c", link_prefix="pdfio")
foreign lib {
	ArrayCreateColorFromICCObj      :: proc(pdf: ^file_t, icc_object: ^obj_t) -> ^array_t ---
	ArrayCreateColorFromMatrix      :: proc(pdf: ^file_t, num_colors: uint, gamma: f64, mtrx: [^][3]f64, white_point: ^f64) -> ^array_t ---
	ArrayCreateColorFromPalette     :: proc(pdf: ^file_t, num_colors: uint, colors: cstring) -> ^array_t ---
	ArrayCreateColorFromPrimaries   :: proc(pdf: ^file_t, num_colors: uint, gamma: f64, wx: f64, wy: f64, rx: f64, ry: f64, gx: f64, gy: f64, bx: f64, by: f64) -> ^array_t ---
	ArrayCreateColorFromStandard    :: proc(pdf: ^file_t, num_colors: uint, cs: cs_t) -> ^array_t ---
	ContentClip                     :: proc(st: ^stream_t, even_odd: bool) -> bool ---
	ContentDrawImage                :: proc(st: ^stream_t, name: cstring, x: f64, y: f64, w: f64, h: f64) -> bool ---
	ContentFill                     :: proc(st: ^stream_t, even_odd: bool) -> bool ---
	ContentFillAndStroke            :: proc(st: ^stream_t, even_odd: bool) -> bool ---
	ContentMatrixConcat             :: proc(st: ^stream_t, m: [^][2]f64) -> bool ---
	ContentMatrixRotate             :: proc(st: ^stream_t, degrees: f64) -> bool ---
	ContentMatrixScale              :: proc(st: ^stream_t, sx: f64, sy: f64) -> bool ---
	ContentMatrixTranslate          :: proc(st: ^stream_t, tx: f64, ty: f64) -> bool ---
	ContentPathClose                :: proc(st: ^stream_t) -> bool ---
	ContentPathCurve                :: proc(st: ^stream_t, x1: f64, y1: f64, x2: f64, y2: f64, x3: f64, y3: f64) -> bool ---
	ContentPathCurve13              :: proc(st: ^stream_t, x1: f64, y1: f64, x3: f64, y3: f64) -> bool ---
	ContentPathCurve23              :: proc(st: ^stream_t, x2: f64, y2: f64, x3: f64, y3: f64) -> bool ---
	ContentPathEnd                  :: proc(st: ^stream_t) -> bool ---
	ContentPathLineTo               :: proc(st: ^stream_t, x: f64, y: f64) -> bool ---
	ContentPathMoveTo               :: proc(st: ^stream_t, x: f64, y: f64) -> bool ---
	ContentPathRect                 :: proc(st: ^stream_t, x: f64, y: f64, width: f64, height: f64) -> bool ---
	ContentRestore                  :: proc(st: ^stream_t) -> bool ---
	ContentSave                     :: proc(st: ^stream_t) -> bool ---
	ContentSetDashPattern           :: proc(st: ^stream_t, phase: f64, on: f64, off: f64) -> bool ---
	ContentSetFillColorDeviceCMYK   :: proc(st: ^stream_t, _c: f64, m: f64, y: f64, k: f64) -> bool ---
	ContentSetFillColorDeviceGray   :: proc(st: ^stream_t, g: f64) -> bool ---
	ContentSetFillColorDeviceRGB    :: proc(st: ^stream_t, r: f64, g: f64, b: f64) -> bool ---
	ContentSetFillColorGray         :: proc(st: ^stream_t, g: f64) -> bool ---
	ContentSetFillColorRGB          :: proc(st: ^stream_t, r: f64, g: f64, b: f64) -> bool ---
	ContentSetFillColorSpace        :: proc(st: ^stream_t, name: cstring) -> bool ---
	ContentSetFlatness              :: proc(st: ^stream_t, f: f64) -> bool ---
	ContentSetLineCap               :: proc(st: ^stream_t, lc: linecap_t) -> bool ---
	ContentSetLineJoin              :: proc(st: ^stream_t, lj: linejoin_t) -> bool ---
	ContentSetLineWidth             :: proc(st: ^stream_t, width: f64) -> bool ---
	ContentSetMiterLimit            :: proc(st: ^stream_t, limit: f64) -> bool ---
	ContentSetStrokeColorDeviceCMYK :: proc(st: ^stream_t, _c: f64, m: f64, y: f64, k: f64) -> bool ---
	ContentSetStrokeColorDeviceGray :: proc(st: ^stream_t, g: f64) -> bool ---
	ContentSetStrokeColorDeviceRGB  :: proc(st: ^stream_t, r: f64, g: f64, b: f64) -> bool ---
	ContentSetStrokeColorGray       :: proc(st: ^stream_t, g: f64) -> bool ---
	ContentSetStrokeColorRGB        :: proc(st: ^stream_t, r: f64, g: f64, b: f64) -> bool ---
	ContentSetStrokeColorSpace      :: proc(st: ^stream_t, name: cstring) -> bool ---
	ContentSetTextCharacterSpacing  :: proc(st: ^stream_t, spacing: f64) -> bool ---
	ContentSetTextFont              :: proc(st: ^stream_t, name: cstring, size: f64) -> bool ---
	ContentSetTextLeading           :: proc(st: ^stream_t, leading: f64) -> bool ---
	ContentSetTextMatrix            :: proc(st: ^stream_t, m: [^][2]f64) -> bool ---
	ContentSetTextRenderingMode     :: proc(st: ^stream_t, mode: textrendering_t) -> bool ---
	ContentSetTextRise              :: proc(st: ^stream_t, rise: f64) -> bool ---
	ContentSetTextWordSpacing       :: proc(st: ^stream_t, spacing: f64) -> bool ---
	ContentSetTextXScaling          :: proc(st: ^stream_t, percent: f64) -> bool ---
	ContentStroke                   :: proc(st: ^stream_t) -> bool ---
	ContentTextBegin                :: proc(st: ^stream_t) -> bool ---
	ContentTextEnd                  :: proc(st: ^stream_t) -> bool ---
	ContentTextMeasure              :: proc(font: ^obj_t, s: cstring, size: f64) -> f64 ---
	ContentTextMoveLine             :: proc(st: ^stream_t, tx: f64, ty: f64) -> bool ---
	ContentTextMoveTo               :: proc(st: ^stream_t, tx: f64, ty: f64) -> bool ---
	ContentTextNewLine              :: proc(st: ^stream_t) -> bool ---
	ContentTextNewLineShow          :: proc(st: ^stream_t, ws: f64, cs: f64, unicode: bool, s: cstring) -> bool ---
	ContentTextNewLineShowf         :: proc(st: ^stream_t, ws: f64, cs: f64, unicode: bool, format: cstring) -> bool ---
	ContentTextNextLine             :: proc(st: ^stream_t) -> bool ---
	ContentTextShow                 :: proc(st: ^stream_t, unicode: bool, s: cstring) -> bool ---
	ContentTextShowf                :: proc(st: ^stream_t, unicode: bool, format: cstring) -> bool ---
	ContentTextShowJustified        :: proc(st: ^stream_t, unicode: bool, num_fragments: uint, offsets: ^f64, fragments: [^]cstring) -> bool ---
	FileCreateFontObjFromBase       :: proc(pdf: ^file_t, name: cstring) -> ^obj_t ---
	FileCreateFontObjFromFile       :: proc(pdf: ^file_t, filename: cstring, unicode: bool) -> ^obj_t ---
	FileCreateICCObjFromFile        :: proc(pdf: ^file_t, filename: cstring, num_colors: uint) -> ^obj_t ---
	FileCreateImageObjFromData      :: proc(pdf: ^file_t, data: cstring, width: uint, height: uint, num_colors: uint, color_data: ^array_t, alpha: bool, interpolate: bool) -> ^obj_t ---
	FileCreateImageObjFromFile      :: proc(pdf: ^file_t, filename: cstring, interpolate: bool) -> ^obj_t ---
	ImageGetBytesPerLine            :: proc(obj: ^obj_t) -> uint ---
	ImageGetHeight                  :: proc(obj: ^obj_t) -> f64 ---
	ImageGetWidth                   :: proc(obj: ^obj_t) -> f64 ---
	PageDictAddColorSpace           :: proc(dict: ^dict_t, name: cstring, data: ^array_t) -> bool ---
	PageDictAddFont                 :: proc(dict: ^dict_t, name: cstring, obj: ^obj_t) -> bool ---
	PageDictAddImage                :: proc(dict: ^dict_t, name: cstring, obj: ^obj_t) -> bool ---
}
