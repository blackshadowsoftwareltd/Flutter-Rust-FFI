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

// Dart function that will be called from Rust to receive streamed data
void onDataReceived(Pointer<Uint8> data, int length) {
  // Convert the data to a Dart list
  final dataList = data.asTypedList(length);
  streamController.add(dataList);
  // Process the streamed data here
  // ...
}

Future<void> startRustStream() async {
  // Call the Rust function and pass the Dart callback
  startStream(Pointer.fromFunction<StreamCallback>(onDataReceived));
  // You can start listening to the stream now
  // Listen to the stream
  streamController.stream.listen((data) {
    log(data.toString());
    // Process the streamed data here
    // ...
  });
}

StreamController<Uint8List> streamController = StreamController<Uint8List>();
