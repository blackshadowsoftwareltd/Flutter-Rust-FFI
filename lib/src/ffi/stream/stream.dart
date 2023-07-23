import 'dart:ffi'
    show IntPtr, NativeFunction, NativeFunctionPointer, Pointer, Uint8, Void;

import '../../../ffi.dart' show dynamicLib;

typedef StreamCallback = Void Function(Pointer<Uint8>, IntPtr);

typedef StartStreamNative = Void Function(
    Pointer<NativeFunction<StreamCallback>>);

final startStream = dynamicLib
    .lookup<NativeFunction<StartStreamNative>>('start_stream')
    .asFunction<void Function(Pointer<NativeFunction<StreamCallback>>)>();
