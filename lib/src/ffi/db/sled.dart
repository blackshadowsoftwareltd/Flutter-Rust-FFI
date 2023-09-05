import 'dart:developer';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter_rust_ffi/src/ffi/ffi.dart';
import 'package:path_provider/path_provider.dart';

typedef OpenDbFunc = Pointer<Void> Function(Pointer<Uint8>);
typedef OpenDbFuncNative = Pointer<Void> Function(Pointer<Uint8>);

final OpenDbFunc _openDb = dynamicLib
    .lookup<NativeFunction<OpenDbFuncNative>>('open_db')
    .asFunction<OpenDbFunc>();

late Pointer<Void> db;

// Open a sled db with a given path
Future<void> openDb() async {
  try {
    final p = await getApplicationDocumentsDirectory();
    final path = p.path.toNativeUtf8();
    db = _openDb(path.cast());
  } catch (e) {
    log(e.toString());
  }
  await Future.delayed(const Duration(seconds: 2));
  log(db.runtimeType.toString());
}
