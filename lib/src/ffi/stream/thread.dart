// ignore_for_file: avoid_print

import 'dart:async' show StreamController;
import 'dart:developer' show log;
import 'dart:ffi' show Pointer, Uint8, Uint8Pointer;
import 'dart:isolate' show Isolate, ReceivePort, SendPort;
import 'dart:typed_data' show Uint8List;

import 'package:ffi/ffi.dart';

import '../ffi.dart' show initDynamicLib;
import 'stream.dart' show SendRecDataRust, startStream;

late SendPort sendPort;
final streamController = StreamController<Uint8List>();
late Isolate isolateStream;
Future<void> startThread() async {
  final receivePort = ReceivePort();
  isolateStream = await Isolate.spawn(
    _isolate,
    [receivePort.sendPort],
    onExit: receivePort.sendPort,
    onError: receivePort.sendPort,
  );
  isolateStream.addOnExitListener(receivePort.sendPort,
      response: 'Isolate Exited');

  receivePort.listen((message) {
    if (message is Uint8List) {
      streamController.add(message);
    }
    log(message.toString());
  });
}

void _isolate(List m) {
  sendPort = m.first;
  startRustStream();
}

void onDataReceived(Pointer<Uint8> data, int length) {
  final dataList = data.asTypedList(length);
  log('in dart thread : $dataList');
  sendPort.send(dataList);
}

void startRustStream() {
  try {
    initDynamicLib();
    String fullName = 'Hello People!';
    final namePtr = fullName.toNativeUtf8();
    final callback = Pointer.fromFunction<SendRecDataRust>(onDataReceived);
    startStream(callback, namePtr);
    calloc.free(namePtr);
  } catch (e) {
    print(e);
  }
}

void closeStreamIsolate() {
  isolateStream.kill();
}
