package pdfio

import "core:c"
import "core:c/libc"

_ :: c
_ :: libc

foreign import lib "pdfio1.lib"

encryption_t :: enum c.int {
	NONE = 0,
	RC4_40,
	RC4_128,
	AES_128,
	AES_256,
}

filter_t :: enum c.int {
	NONE,
	ASCIIHEX,
	ASCII85,
	CCITTFAX,
	CRYPT,
	DCT,
	FLATE,
	JBIG2,
	JPX,
	LZW,
	RUNLENGTH,
}

permission_e :: enum c.int {
	NONE = 0,
	PRINT = 4,
	MODIFY = 8,
	COPY = 16,
	ANNOTATE = 32,
	FORMS = 256,
	READING = 512,
	ASSEMBLE = 1024,
	PRINT_HIGH = 2048,
	ALL = max(c.int),
}

rect_t :: struct {
	x1: f64,
	y1: f64,
	x2: f64,
	y2: f64,
}

valtype_t :: enum c.int {
	NONE,
	ARRAY,
	BINARY,
	BOOLEAN,
	DATE,
	DICT,
	INDIRECT,
	NAME,
	NULL,
	NUMBER,
	STRING,
}

error_cb_t :: proc "c" (^file_t, cstring, rawptr) -> bool

dict_t :: struct {}

dict_cb_t :: proc "c" (^dict_t, cstring, rawptr) -> bool

obj_t :: struct {}

array_t :: struct {}

file_t :: struct {}

stream_t :: struct {}

password_cb_t :: proc "c" (rawptr, cstring) -> cstring

permission_t :: distinct i32

output_cb_t :: proc "c" (rawptr, rawptr, uint) -> int

@(default_calling_convention="c", link_prefix="pdfio")
foreign lib {
	ArrayAppendArray    :: proc(a: ^array_t, value: ^array_t) -> bool ---
	ArrayAppendBinary   :: proc(a: ^array_t, value: cstring, valuelen: uint) -> bool ---
	ArrayAppendBoolean  :: proc(a: ^array_t, value: bool) -> bool ---
	ArrayAppendDate     :: proc(a: ^array_t, value: libc.time_t) -> bool ---
	ArrayAppendDict     :: proc(a: ^array_t, value: ^dict_t) -> bool ---
	ArrayAppendName     :: proc(a: ^array_t, value: cstring) -> bool ---
	ArrayAppendNumber   :: proc(a: ^array_t, value: f64) -> bool ---
	ArrayAppendObj      :: proc(a: ^array_t, value: ^obj_t) -> bool ---
	ArrayAppendString   :: proc(a: ^array_t, value: cstring) -> bool ---
	ArrayCopy           :: proc(pdf: ^file_t, a: ^array_t) -> ^array_t ---
	ArrayCreate         :: proc(pdf: ^file_t) -> ^array_t ---
	ArrayGetArray       :: proc(a: ^array_t, n: uint) -> ^array_t ---
	ArrayGetBinary      :: proc(a: ^array_t, n: uint, length: ^uint) -> cstring ---
	ArrayGetBoolean     :: proc(a: ^array_t, n: uint) -> bool ---
	ArrayGetDate        :: proc(a: ^array_t, n: uint) -> libc.time_t ---
	ArrayGetDict        :: proc(a: ^array_t, n: uint) -> ^dict_t ---
	ArrayGetName        :: proc(a: ^array_t, n: uint) -> cstring ---
	ArrayGetNumber      :: proc(a: ^array_t, n: uint) -> f64 ---
	ArrayGetObj         :: proc(a: ^array_t, n: uint) -> ^obj_t ---
	ArrayGetSize        :: proc(a: ^array_t) -> uint ---
	ArrayGetString      :: proc(a: ^array_t, n: uint) -> cstring ---
	ArrayGetType        :: proc(a: ^array_t, n: uint) -> valtype_t ---
	ArrayRemove         :: proc(a: ^array_t, n: uint) -> bool ---
	DictClear           :: proc(dict: ^dict_t, key: cstring) -> bool ---
	DictCopy            :: proc(pdf: ^file_t, dict: ^dict_t) -> ^dict_t ---
	DictCreate          :: proc(pdf: ^file_t) -> ^dict_t ---
	DictGetArray        :: proc(dict: ^dict_t, key: cstring) -> ^array_t ---
	DictGetBinary       :: proc(dict: ^dict_t, key: cstring, length: ^uint) -> cstring ---
	DictGetBoolean      :: proc(dict: ^dict_t, key: cstring) -> bool ---
	DictGetDate         :: proc(dict: ^dict_t, key: cstring) -> libc.time_t ---
	DictGetDict         :: proc(dict: ^dict_t, key: cstring) -> ^dict_t ---
	DictGetKey          :: proc(dict: ^dict_t, n: uint) -> cstring ---
	DictGetName         :: proc(dict: ^dict_t, key: cstring) -> cstring ---
	DictGetNumPairs     :: proc(dict: ^dict_t) -> uint ---
	DictGetNumber       :: proc(dict: ^dict_t, key: cstring) -> f64 ---
	DictGetObj          :: proc(dict: ^dict_t, key: cstring) -> ^obj_t ---
	DictGetRect         :: proc(dict: ^dict_t, key: cstring, rect: ^rect_t) -> ^rect_t ---
	DictGetString       :: proc(dict: ^dict_t, key: cstring) -> cstring ---
	DictGetType         :: proc(dict: ^dict_t, key: cstring) -> valtype_t ---
	DictIterateKeys     :: proc(dict: ^dict_t, cb: dict_cb_t, cb_data: rawptr) ---
	DictSetArray        :: proc(dict: ^dict_t, key: cstring, value: ^array_t) -> bool ---
	DictSetBinary       :: proc(dict: ^dict_t, key: cstring, value: cstring, valuelen: uint) -> bool ---
	DictSetBoolean      :: proc(dict: ^dict_t, key: cstring, value: bool) -> bool ---
	DictSetDate         :: proc(dict: ^dict_t, key: cstring, value: libc.time_t) -> bool ---
	DictSetDict         :: proc(dict: ^dict_t, key: cstring, value: ^dict_t) -> bool ---
	DictSetName         :: proc(dict: ^dict_t, key: cstring, value: cstring) -> bool ---
	DictSetNull         :: proc(dict: ^dict_t, key: cstring) -> bool ---
	DictSetNumber       :: proc(dict: ^dict_t, key: cstring, value: f64) -> bool ---
	DictSetObj          :: proc(dict: ^dict_t, key: cstring, value: ^obj_t) -> bool ---
	DictSetRect         :: proc(dict: ^dict_t, key: cstring, value: ^rect_t) -> bool ---
	DictSetString       :: proc(dict: ^dict_t, key: cstring, value: cstring) -> bool ---
	DictSetStringf      :: proc(dict: ^dict_t, key: cstring, format: cstring) -> bool ---
	FileClose           :: proc(pdf: ^file_t) -> bool ---
	FileCreate          :: proc(filename: cstring, version: cstring, media_box: ^rect_t, crop_box: ^rect_t, error_cb: error_cb_t, error_data: rawptr) -> ^file_t ---
	FileCreateArrayObj  :: proc(pdf: ^file_t, array: ^array_t) -> ^obj_t ---
	FileCreateNameObj   :: proc(pdf: ^file_t, name: cstring) -> ^obj_t ---
	FileCreateNumberObj :: proc(pdf: ^file_t, number: f64) -> ^obj_t ---
	FileCreateObj       :: proc(pdf: ^file_t, dict: ^dict_t) -> ^obj_t ---
	FileCreateOutput    :: proc(output_cb: output_cb_t, output_ctx: rawptr, version: cstring, media_box: ^rect_t, crop_box: ^rect_t, error_cb: error_cb_t, error_data: rawptr) -> ^file_t ---
	FileCreatePage      :: proc(pdf: ^file_t, dict: ^dict_t) -> ^stream_t ---
	FileCreateStringObj :: proc(pdf: ^file_t, s: cstring) -> ^obj_t ---
	FileCreateTemporary :: proc(buffer: cstring, bufsize: uint, version: cstring, media_box: ^rect_t, crop_box: ^rect_t, error_cb: error_cb_t, error_data: rawptr) -> ^file_t ---
	FileFindObj         :: proc(pdf: ^file_t, number: uint) -> ^obj_t ---
	FileGetAuthor       :: proc(pdf: ^file_t) -> cstring ---
	FileGetCatalog      :: proc(pdf: ^file_t) -> ^dict_t ---
	FileGetCreationDate :: proc(pdf: ^file_t) -> libc.time_t ---
	FileGetCreator      :: proc(pdf: ^file_t) -> cstring ---
	FileGetID           :: proc(pdf: ^file_t) -> ^array_t ---
	FileGetKeywords     :: proc(pdf: ^file_t) -> cstring ---
	FileGetName         :: proc(pdf: ^file_t) -> cstring ---
	FileGetNumObjs      :: proc(pdf: ^file_t) -> uint ---
	FileGetNumPages     :: proc(pdf: ^file_t) -> uint ---
	FileGetObj          :: proc(pdf: ^file_t, n: uint) -> ^obj_t ---
	FileGetPage         :: proc(pdf: ^file_t, n: uint) -> ^obj_t ---
	FileGetPermissions  :: proc(pdf: ^file_t, encryption: ^encryption_t) -> permission_t ---
	FileGetProducer     :: proc(pdf: ^file_t) -> cstring ---
	FileGetSubject      :: proc(pdf: ^file_t) -> cstring ---
	FileGetTitle        :: proc(pdf: ^file_t) -> cstring ---
	FileGetVersion      :: proc(pdf: ^file_t) -> cstring ---
	FileOpen            :: proc(filename: cstring, password_cb: password_cb_t, password_data: rawptr, error_cb: error_cb_t, error_data: rawptr) -> ^file_t ---
	FileSetAuthor       :: proc(pdf: ^file_t, value: cstring) ---
	FileSetCreationDate :: proc(pdf: ^file_t, value: libc.time_t) ---
	FileSetCreator      :: proc(pdf: ^file_t, value: cstring) ---
	FileSetKeywords     :: proc(pdf: ^file_t, value: cstring) ---
	FileSetPermissions  :: proc(pdf: ^file_t, permissions: permission_t, encryption: encryption_t, owner_password: cstring, user_password: cstring) -> bool ---
	FileSetSubject      :: proc(pdf: ^file_t, value: cstring) ---
	FileSetTitle        :: proc(pdf: ^file_t, value: cstring) ---
	ObjClose            :: proc(obj: ^obj_t) -> bool ---
	ObjCopy             :: proc(pdf: ^file_t, srcobj: ^obj_t) -> ^obj_t ---
	ObjCreateStream     :: proc(obj: ^obj_t, compression: filter_t) -> ^stream_t ---
	ObjGetArray         :: proc(obj: ^obj_t) -> ^array_t ---
	ObjGetDict          :: proc(obj: ^obj_t) -> ^dict_t ---
	ObjGetGeneration    :: proc(obj: ^obj_t) -> u16 ---
	ObjGetLength        :: proc(obj: ^obj_t) -> uint ---
	ObjGetName          :: proc(obj: ^obj_t) -> cstring ---
	ObjGetNumber        :: proc(obj: ^obj_t) -> uint ---
	ObjGetSubtype       :: proc(obj: ^obj_t) -> cstring ---
	ObjGetType          :: proc(obj: ^obj_t) -> cstring ---
	ObjOpenStream       :: proc(obj: ^obj_t, decode: bool) -> ^stream_t ---
	PageCopy            :: proc(pdf: ^file_t, srcpage: ^obj_t) -> bool ---
	PageGetNumStreams   :: proc(page: ^obj_t) -> uint ---
	PageOpenStream      :: proc(page: ^obj_t, n: uint, decode: bool) -> ^stream_t ---
	StreamClose         :: proc(st: ^stream_t) -> bool ---
	StreamConsume       :: proc(st: ^stream_t, bytes: uint) -> bool ---
	StreamGetToken      :: proc(st: ^stream_t, buffer: cstring, bufsize: uint) -> bool ---
	StreamPeek          :: proc(st: ^stream_t, buffer: rawptr, bytes: uint) -> int ---
	StreamPrintf        :: proc(st: ^stream_t, format: cstring) -> bool ---
	StreamPutChar       :: proc(st: ^stream_t, ch: i32) -> bool ---
	StreamPuts          :: proc(st: ^stream_t, s: cstring) -> bool ---
	StreamRead          :: proc(st: ^stream_t, buffer: rawptr, bytes: uint) -> int ---
	StreamWrite         :: proc(st: ^stream_t, buffer: rawptr, bytes: uint) -> bool ---
	StringCreate        :: proc(pdf: ^file_t, s: cstring) -> cstring ---
	StringCreatef       :: proc(pdf: ^file_t, format: cstring) -> cstring ---
}
