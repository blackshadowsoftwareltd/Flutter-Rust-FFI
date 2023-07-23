import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stream.dart';
import 'thread.dart';

final rustEventProvider =
    StreamProvider<Uint8List>((ref) => streamController.stream);

final startRustProvider =
    AsyncNotifierProvider<_StartRust, void>(_StartRust.new);

class _StartRust extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async => await startThread();
}
