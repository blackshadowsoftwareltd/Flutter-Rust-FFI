import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stream.dart';

final rustEventProvider =
    StreamProvider<Uint8List>((ref) => streamController.stream);
// Uint8List
final startRustProvider =
    AsyncNotifierProvider<_StartRust, void>(_StartRust.new);

class _StartRust extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    Future.microtask(() {
      startRustStream();
    });
    // startRustStream();
  }
}

void onDataReceived(Pointer<Uint8> data, int length) {
  final dataList = data.asTypedList(length);
  print(dataList);
  streamController.add(dataList);
  // ...
}

void startRustStream() async {
  // Start listening to the stream before calling the Rust code
  // final subscription = streamController.stream.listen((data) {
  //   log(data.toString());
  // });
  startStream(Pointer.fromFunction<StreamCallback>(onDataReceived));
  // startStream(
  //     Pointer.fromFunction<StreamCallback>((Pointer<Uint8> x, IntPtr y) {
  //   return startRustStream(x, y);
  // }));

  // await for (final data in streamController.stream) {
  //   log(data.toString());
  // }
  // subscription.onDone(() {
  //   print('Rust stream is done');
  // });
}
