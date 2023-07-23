import 'dart:ffi';
import 'package:ffi/ffi.dart';
import '../../../ffi.dart';

typedef PCC = Pointer<Utf8> Function(Pointer<Uint8> name, Int32 age);
typedef PCDart = Pointer<Utf8> Function(Pointer<Uint8> name, int age);

final profileConcat = dynamicLib.lookupFunction<PCC, PCDart>('profile_concat');

String concatStringUsingRust(String fullName, int age) {
  final namePtr = fullName.toNativeUtf8();
  final resultPtr = profileConcat(namePtr.cast(), age);
  final result = resultPtr.toDartString();
  calloc.free(namePtr);
  calloc.free(resultPtr);
  return result;
}
