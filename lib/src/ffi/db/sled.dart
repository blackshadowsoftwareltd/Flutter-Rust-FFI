import 'dart:developer';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter_rust_ffi/src/ffi/ffi.dart';
import 'package:path_provider/path_provider.dart';

typedef OpenDbRust = Void Function(Pointer<Uint8> path);
typedef OpenDbDart = void Function(Pointer<Uint8>);

final void Function(Pointer<Uint8>) openDbLookup =
    dynamicLib.lookupFunction<OpenDbRust, OpenDbDart>('open_db');

// Open a sled db with a given path
Future<void> openDb() async {
  try {
    final p = await getApplicationDocumentsDirectory();
    final path = p.path.toNativeUtf8();
    openDbLookup(path.cast());
  } catch (e) {
    log(e.toString());
  }
  await Future.delayed(const Duration(seconds: 2));
}
