import 'dart:async';
import 'dart:ffi';

import 'package:flutter_rust_ffi/src/ffi/ffi.dart';

typedef RustSumCallback = Void Function(Int32);
typedef RustSumFunction = void Function(int value);

final rustSum =
    dynamicLib.lookupFunction<RustSumCallback, RustSumFunction>('stream_to');

void startStreamTo() {
  startCounterStream().listen((counter) {
    rustSum(counter);
  });
}

Stream<int> startCounterStream() async* {
  while (counter < 10) {
    await Future.delayed(const Duration(seconds: 1));
    yield counter++;
  }
}

int counter = 0;
