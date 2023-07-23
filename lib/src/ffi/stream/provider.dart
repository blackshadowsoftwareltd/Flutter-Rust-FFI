import 'dart:async' show FutureOr;
import 'dart:typed_data' show Uint8List;

import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncNotifier, AsyncNotifierProvider, StreamProvider;

import 'thread.dart' show startThread, streamController;

final rustEventProvider =
    StreamProvider<Uint8List>((ref) => streamController.stream);

final startRustProvider =
    AsyncNotifierProvider<_StartRust, void>(_StartRust.new);

class _StartRust extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async => await startThread();
}
