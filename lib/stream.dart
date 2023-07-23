import 'dart:developer';
import 'dart:ffi'; // For FFI
import 'dart:typed_data'; // For Uint8List
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ffi.dart'; // For streams

typedef StreamCallback = Void Function(Pointer<Uint8>, IntPtr);

typedef StartStreamNative = Void Function(
    Pointer<NativeFunction<StreamCallback>>);

final startStream = dynamicLib
    .lookup<NativeFunction<StartStreamNative>>('start_stream')
    .asFunction<void Function(Pointer<NativeFunction<StreamCallback>>)>();

