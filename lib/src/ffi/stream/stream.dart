import 'dart:ffi'
    show DynamicLibraryExtension, IntPtr, NativeFunction, Pointer, Uint8, Void;

import 'package:ffi/ffi.dart' show Utf8;

import '../ffi.dart' show dynamicLib;

typedef RustStreamCallback = Pointer<NativeFunction<SendRecDataRust>>;
typedef StartChannelR = Void Function(
    RustStreamCallback callback, Pointer<Utf8> name);
typedef StartChannelD = void Function(
    RustStreamCallback callback, Pointer<Utf8> name);

typedef SendRecDataRust = Void Function(Pointer<Uint8> data, IntPtr len);
typedef SendRecDataDart = void Function(Pointer<Uint8> data, IntPtr len);

final startStream =
    dynamicLib.lookupFunction<StartChannelR, StartChannelD>('start_stream');
