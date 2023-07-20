import 'dart:developer';
import 'dart:ffi'; // For FFI
import 'dart:typed_data'; // For Uint8List
import 'dart:async';

import 'ffi.dart'; // For streams

typedef StreamCallback = Void Function(Pointer<Uint8>, IntPtr);

typedef StartStreamNative = Void Function(
    Pointer<NativeFunction<StreamCallback>>);

final startStream = dynamicLib
    .lookup<NativeFunction<StartStreamNative>>('start_stream')
    .asFunction<void Function(Pointer<NativeFunction<StreamCallback>>)>();

void onDataReceived(Pointer<Uint8> data, int length) {
  final dataList = data.asTypedList(length);
  print(dataList);
  streamController.add(dataList);
  // ...
}

void startRustStream() async {
  startStream(Pointer.fromFunction<StreamCallback>(onDataReceived));

  await for (final data in streamController.stream) {
    log(data.toString());
  }
}

final streamController = StreamController<Uint8List>();
