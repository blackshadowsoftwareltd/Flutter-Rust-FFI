import 'dart:async' show StreamController;
import 'dart:developer' show log;
import 'dart:ffi' show Pointer, Uint8, Uint8Pointer;
import 'dart:isolate' show Isolate, ReceivePort, SendPort;
import 'dart:typed_data' show Uint8List;

import '../ffi.dart' show initDynamicLib;
import 'stream.dart' show StreamCallback, startStream;

late SendPort sendPort;
final streamController = StreamController<Uint8List>();

Future<void> startThread() async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(
    _isolate,
    [receivePort.sendPort],
    onExit: receivePort.sendPort,
    onError: receivePort.sendPort,
  );
  isolate.addOnExitListener(receivePort.sendPort, response: 'Isolate Exited');

  receivePort.listen((message) {
    if (message is Uint8List) {
      streamController.add(message);
    }
    log(message.toString());
  });
}

Future<void> _isolate(List m) async {
  sendPort = m.first;
  startRustStream();
}

void onDataReceived(Pointer<Uint8> data, int length) {
  final dataList = data.asTypedList(length);
  log('in dart thread : $dataList');
  sendPort.send(dataList);
}

void startRustStream() async {
  initDynamicLib();
  startStream(Pointer.fromFunction<StreamCallback>(onDataReceived));
}
